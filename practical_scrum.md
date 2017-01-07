# Practical scrum for agile teams
Introspections on practicing scrum for 3 years.

## Table of contents
<!-- MarkdownTOC -->

	- [Misconceptions](#misconceptions)
	- [What is scrum?](#what-is-scrum)
		- [History of scrum](#history-of-scrum)
		- [Systems process management approaches](#systems-process-management-approaches)
		- [3 important principles of empirical control theory](#3-important-principles-of-empirical-control-theory)
		- [4 formal scrum events](#4-formal-scrum-events)
	- [Roles in a scrum](#roles-in-a-scrum)
		- [Scrum team](#scrum-team)
		- [Product owner](#product-owner)
			- [PO responsibilities](#po-responsibilities)
		- [Development team](#development-team)
		- [Scrum master](#scrum-master)
	- [During a sprint](#during-a-sprint)
- [Managing the software process via scrum](#managing-the-software-process-via-scrum)
	- [Scrum process terminologies:](#scrum-process-terminologies)
		- [Product backlog](#product-backlog)
		- [User story](#user-story)
		- [Epics](#epics)
		- [Scrum planning and sprints](#scrum-planning-and-sprints)
	- [Long term plans](#long-term-plans)

<!-- /MarkdownTOC -->


## Misconceptions
What scrum is not? - not a software development process. It is independent of industry, in fact can be applied even in your household.

Scrum is not all about the stand-up meetings - although that is sometimes trademark of teams that follow scrum. The stand up meetings is a means to improve communication and improve camaraderie.

## What is scrum?
Its a framework for teams that want to be self-organizing, agile and adapt quickly to changing requirements and deliver in short manageable time line.

It is surprising to observe even how considerably large projects can be broken down into smaller pieces and delivered in half or quarter of the projected time line and costs by adopting scrum methodology.

### History of scrum
Founded on empirical process control theory or empiricism. Knowledge comes from experience and emphasis on making decisions based on what is known. Thus, scrum employs iterative, incremental approach to optimize predictability and control risk.

### Systems process management approaches
 * **Lean** - The goal of lean is simple: minimize the time between customer request and fulfillment by continually improving and reducing non-value adding work.
 * **Agile** - Uses business value as primary measure of progress. Reduces risk through continuous delivery
 * **Scrum** - a wrapper around agile and is a process to practice agile delivery / development. Scrum is industry and technology agnostic.

In this light, it is relevant to discuss about the key points of Agile manifesto: An agile process values:
 - **Individual and interactions** over processes and tools
 - **Working software** over detailed doc explaining the eccentricities and confusions while using the product
 - **Customer collaboration** over contract negotiation
 - **Responding to change (agile)** over following a process

### 3 important principles of empirical control theory
 - Transparency - a common metric to measure progress and a shared definition of done
 - Inspection - regular and frequent inspection of progress is required. But inspection should never get in the way of work or stop or modify the project.
 - Adaptation - if inspection leads to a discovery of something in deviation then an adjustment should be made at the earliest.

### 4 formal scrum events
For inspection and adaptation, scrum describes 4 formal events
 
 - sprint planning
 - daily scrum
 - sprint review
 - sprint retrospective

## Roles in a scrum
### Scrum team
A team consists of 
 - product owner
 - development team
 - scrum master

Scrum teams are self organizing - they decide how to work on things without external direction, cross functional - have all competencies to finish the project without relying on other teams

### Product owner
Manages product backlog - furnishing PBI with details, prioritizing it, exposing it to all team members.

Only PO has right to change the PBI and the entire org must respect this decision. The dev team works from this PBI and no one can inject a different set of requirements bypassing the PO.

#### PO responsibilities
 - Manage profitability and ROI. A PO does this by prioritizing the backlog to maximize the business value delivered. To start with, the PO must arrive at a way to determine the value delivered, a metric of sorts
 - Call for releases. PO decides what constitutes a minimum shippable product. PO also has liberty to move the release time line forward or backward to maximize the ROI.
 - Guides product development. PO would establish, nurture and communicate the vision. Knows what to build and in what sequence (note, how to build is not a requirement).

### Development team
Self organizing, not even the scrum master tells how to turn the backlog into products. Scrum calls **everyone a developer** no matter the work performed by the person, no exceptions. No sub teams can exist within a scrum team. 3-9 is a valid team size for scruming, not including PO and SM unless they also act as development team.

### Scrum master
Ensure scrum is understood and practiced. **Servant-leader** role in helping teams be self org, helping PO with backlog grooming, arrangement, interfacing with external influencers etc.

## During a sprint
A time period, preferably less than a month, during which a product of value and quality that meets 'done' definition can be created. Major events during sprint - sprint planning, daily scrum, dev work, sprint review

# Managing the software process via scrum
To begin with, let us review the terminologies involved in a scrum process:

## Scrum process terminologies:
### Product backlog
The backlog contains the list of all requirements. Each item (a PBI - product backlog item) in the backlog is written as a **user story**. The PO prioritizes the backlog and arranges the items in the order in which it has to be finished. The order of backlog should maximize the ROI.

### User story
Resist from writing a user story until you have a clear understanding of what you are building. User stories are of format:

	As a <role>,
	I can <feature / function>,
	so that <goal / value>.

For example, the user story for backup camera in a car can be written as
	
	As a driver, I can use the back up camera when I am reversing the car so I can see what's behind the car more clearly than what my rear view mirrors show.

What is management without acronym :) Lets throw one for user stories.. A user story is good if its INVESTable: Independent, Negotiable, Valuable, Estimatable, Small and Testable.

### Epics
When a bunch of user stories come together, they form an epic. Consider an epic as a large feature that is composed of many sub features that together make a functionality complete and usable. In the case of the backup camera we user story we visited earlier, an epic would be a collection of few more user stories such as:

Backup camera Epic:

	1. Turn on back up camera when put in reverse
	2. Enhance back up camera feed with steering predictors / guides
	3. Alert with audio and steering wheel vibrators when a moving object is detected in back up camera feed
	4. Alert lane departures using back up camera feed.

### Scrum planning and sprints
In the agile management approach, you plan for releases in three levels. First is the `release plan`. Here, you arrange the PBIs in the order of importance or value. The PO takes a call on what to include and what to leave out. Each release is composed of one or more `sprints`. A sprint is a short two to three week period where the entire scrum team comes together, works on one or two PBIs and finishes it.

## Long term plans
It's great to be able to write user stories, but there will be times when you cannot. For instance, can you know and write out user stories for 2 years from now? You cannot, and that is part of being agile. In such cases, your backlog is going to be a mix of stories that are refined and Epics which are large stories that need to be groomed and broken down.