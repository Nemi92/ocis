<?php declare(strict_types=1);
/**
 * @author Viktor Scharf <scharf.vi@gmail.com>
 *
 * @copyright Copyright (c) 2023, ownCloud GmbH
 * @license AGPL-3.0
 *
 * This code is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License, version 3,
 * as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License, version 3,
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

use Behat\Behat\Context\Context;
use Behat\Behat\Hook\Scope\BeforeScenarioScope;
use PHPUnit\Framework\Assert;
use Psr\Http\Message\ResponseInterface;
use TestHelpers\GraphHelper;
use Behat\Gherkin\Node\TableNode;

require_once 'bootstrap.php';

/**
 * Acceptance test steps related to testing sharing ng features
 */
class SharingNgContext implements Context {
	private FeatureContext $featureContext;
	private SpacesContext $spacesContext;

	/**
	 * This will run before EVERY scenario.
	 * It will set the properties for this object.
	 *
	 * @BeforeScenario
	 *
	 * @param BeforeScenarioScope $scope
	 *
	 * @return void
	 */
	public function before(BeforeScenarioScope $scope): void {
		// Get the environment
		$environment = $scope->getEnvironment();
		// Get all the contexts you need in this context from here
		$this->featureContext = $environment->getContext('FeatureContext');
		$this->spacesContext = $environment->getContext('SpacesContext');
	}

	/**
	 * @param string $user
	 * @param TableNode|null $body
	 *
	 * @return ResponseInterface
	 * @throws Exception
	 * @throws \GuzzleHttp\Exception\GuzzleException
	 */
	public function createLinkShare(string $user, TableNode $body): ResponseInterface {
		$bodyRows = $body->getRowsHash();
		$space = $bodyRows['space'];
		$resourceType = $bodyRows['resourceType'];
		$resource = $bodyRows['resource'];

		$spaceId = ($this->spacesContext->getSpaceByName($user, $space))["id"];
		if ($resourceType === 'folder') {
			$itemId = $this->spacesContext->getResourceId($user, $space, $resource);
		} else {
			$itemId = $this->spacesContext->getFileId($user, $space, $resource);
		}

		$bodyRows['displayName'] = $bodyRows['displayName'] ?? null;
		$bodyRows['expirationDateTime'] = $bodyRows['expirationDateTime'] ?? null;
		$bodyRows['password'] = $bodyRows['password'] ?? null;
		$body = [
			'type' => $bodyRows['role'],
			'displayName' => $bodyRows['displayName'],
			'expirationDateTime' => $bodyRows['expirationDateTime'],
			'password' => $this->featureContext->getActualPassword($bodyRows['password'])
		];

		return GraphHelper::createLinkShare(
			$this->featureContext->getBaseUrl(),
			$this->featureContext->getStepLineRef(),
			$user,
			$this->featureContext->getPasswordForUser($user),
			$spaceId,
			$itemId,
			\json_encode($body)
		);
	}

	/**
	 * @When /^user "([^"]*)" gets permissions list for (folder|file) "([^"]*)" of the space "([^"]*)" using the Graph API$/
	 *
	 * @param string $user
	 * @param string $fileOrFolder   (file|folder)
	 * @param string $resource
	 * @param string $space
	 *
	 * @return void
	 * @throws Exception
	 */
	public function theUserPermissionsListOfResource(string $user, string $fileOrFolder, string $resource, string $space):void {
		$spaceId = ($this->spacesContext->getSpaceByName($user, $space))["id"];

		if ($fileOrFolder === 'folder') {
			$itemId = $this->spacesContext->getResourceId($user, $space, $resource);
		} else {
			$itemId = $this->spacesContext->getFileId($user, $space, $resource);
		}
		$this->featureContext->setResponse(
			GraphHelper::getPermissionsList(
				$this->featureContext->getBaseUrl(),
				$this->featureContext->getStepLineRef(),
				$user,
				$this->featureContext->getPasswordForUser($user),
				$spaceId,
				$itemId
			)
		);
	}

	/**
	 * @When /^user "([^"]*)" sends the following share invitation using the Graph API:$/
	 *
	 * @param string $user
	 * @param TableNode $table
	 *
	 * @return void
	 * @throws Exception
	 */
	public function userSendsTheFollowingShareInvitationUsingTheGraphApi(string $user, TableNode $table): void {
		$rows = $table->getRowsHash();
		$spaceId = ($this->spacesContext->getSpaceByName($user, $rows['space']))["id"];

		$itemId = ($rows['resourceType'] === 'folder')
			? $this->spacesContext->getResourceId($user, $rows['space'], $rows['resource'])
			: $this->spacesContext->getFileId($user, $rows['space'], $rows['resource']);

		$shareeId = ($rows['shareType'] === 'user')
			? $this->featureContext->getAttributeOfCreatedUser($rows['sharee'], 'id')
			: $this->featureContext->getAttributeOfCreatedGroup($rows['sharee'], 'id');

		$role = $rows['role'] ?? null;
		$permission = $rows['permission'] ?? null;
		$expireDate = $rows["expireDate"] ?? null;

		$this->featureContext->setResponse(
			GraphHelper::sendSharingInvitation(
				$this->featureContext->getBaseUrl(),
				$this->featureContext->getStepLineRef(),
				$user,
				$this->featureContext->getPasswordForUser($user),
				$spaceId,
				$itemId,
				$shareeId,
				$rows['shareType'],
				$role,
				$permission,
				$expireDate
			)
		);
	}

	/**
	 * @When /^user "([^"]*)" creates the following link share using the Graph API:$/
	 *
	 * @param string $user
	 * @param TableNode|null $body
	 *
	 * @return void
	 * @throws \GuzzleHttp\Exception\GuzzleException
	 */
	public function userCreatesAPublicLinkShareWithSettings(string $user, TableNode  $body):void {
		$response = $this->createLinkShare($user, $body);
		$this->featureContext->setResponse($response);
	}

	/**
	 * @Given /^user "([^"]*)" has created the following link share:$/
	 *
	 * @param string $user
	 * @param TableNode|null $body
	 *
	 * @return void
	 * @throws \GuzzleHttp\Exception\GuzzleException
	 */
	public function userHasCreatedTheFollowingLinkShare(string $user, TableNode  $body): void {
		$response = $this->createLinkShare($user, $body);
		$this->featureContext->theHTTPStatusCodeShouldBe(200, "Failed while creating public share link!", $response);
		$this->featureContext->shareNgAddToCreatedLinkShares($response);
	}

	/**
	 * @When /^user "([^"]*)" updates the last public link share using the Graph API with$/
	 *
	 * @param string $user
	 * @param TableNode|null $body
	 *
	 * @return void
	 * @throws Exception
	 */
	public function userUpdatesLastPublicLinkShareUsingTheGraphApiWith(string $user, TableNode  $body):void {
		$bodyRows = $body->getRowsHash();
		$space = $bodyRows['space'];
		$resourceType = $bodyRows['resourceType'];
		$resource = $bodyRows['resource'];
		$spaceId = ($this->spacesContext->getSpaceByName($user, $space))["id"];
		if ($resourceType === 'folder') {
			$itemId = $this->spacesContext->getResourceId($user, $space, $resource);
		} else {
			$itemId = $this->spacesContext->getFileId($user, $space, $resource);
		}

		if (\array_key_exists('role', $bodyRows) && \array_key_exists('expirationDateTime', $bodyRows)) {
			$body = [
				"expirationDateTime" => $bodyRows['expirationDateTime'],
				"link" => [
					"type" => $bodyRows['role']
				]
			];
		} elseif (\array_key_exists('role', $bodyRows)) {
			$body = [
				"link" => [
					"type" => $bodyRows['role']
				]
			];
		} elseif (\array_key_exists('expirationDateTime', $bodyRows)) {
			$body = [
				"expirationDateTime" => $bodyRows['expirationDateTime']
			];
		} else {
			throw new Error('Expiration date or role is missing to update for share link!');
		}

		$this->featureContext->setResponse(
			GraphHelper::updateLinkShare(
				$this->featureContext->getBaseUrl(),
				$this->featureContext->getStepLineRef(),
				$user,
				$this->featureContext->getPasswordForUser($user),
				$spaceId,
				$itemId,
				\json_encode($body),
				$this->featureContext->shareNgGetLastCreatedLinkShareID()
			)
		);
	}
}