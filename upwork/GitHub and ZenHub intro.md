# GitHub and ZenHub

Open source projects contain a number of Github Repos used as the repository for documentation and tracking. The planning and tracking of work within an individual repo can be achieved simply through the use of Github’s built-in functionality. To track the progress of the projects across multiple repos, a third-party tool is required. The tool chosen to fulfill this role is Zenhub. This tool provides sufficient planning and tracking capabilities from simply tracking work across a Kanban board.

Zenhub supplements the project tracking functionality by Github by aggregating the issues from multiple repos into a workspace which is then a single point for reporting. From the workspace, Zenhub offers a Kanban Board, Reports, and a Roadmap to track and report progress.

## Installation process:
1. Go to https://chrome.google.com/webstore/detail/zenhub-for-github/ogcgkffhplmphkaahpmffcafajaocjbd/related and add the extension to chrome.
2. Go to https://github.com/filetrust/Open-Source and the “ZendHub” tab should be added after “Pull requests” tab
3. Click on the ZendHub tab and message “We are building your Workspace” should be displayed. It could take some time, if needed, refresh the site.
4. After the configuration is done, tickets for all repos should be displayed. You can select the repos to include by clicking on Repos dropdown.

For more information and training: https://help.zenhub.com/support/solutions/43000365193


## How to work with Github Issues
* Review the issues in "To Do" Column
* Assign one of them to you or coordinate with PM to open new issue
* Move it "In Progress"
* Write in corresponding channel, which issue you have taken
* Start working on it
* Share early and often the status(work if possible in small chunks) in the channel and also update the GITHub issue
* When issue is completed, update/attach to the issue the files/instructions/images/wireframes
* All submissions to GIT repo to be done with Pull Request, put GITHub issue number as reference.
* For having attention when PR needs review, use label "with-pr"


## Important notes:
* All submissions to be done via Pull Requests
* Use corresponding channel to ask questions and share work
* Work as a team to collaborate
* At this stage it is ok for multiple resources to be allocated to the same issue, just share status and collaborate
* Dont submit large numbers of files on your PR, only the files that are required. Having 265 files in PR makes it impossible to review.
* To help with reviewing the PRs please add the screenshots and comments of what supposed to be reviewed to the issue
* Think of the reviewer flow while submitting for review


## GitHub Boards Descriptions(New Issues, Backlog, In Progress, Closed)
* New Issues are newly created issues
* Backlog are upcoming issues that are immediate priorities. Issues here should be prioritized top-to-bottom in the pipeline.
* In Progress are issues that somebody is ACTIVELY WORKING ON RIGHT NOW (this last bit is important since you are clocking for the day, and have not move that issue the To Review status, then move it back to the backlog
* In Review/QA we have the issues that need a review from a member of the Glasswall team (important: only members of the Glasswall team should move issues from the Review status to the Closed status)
