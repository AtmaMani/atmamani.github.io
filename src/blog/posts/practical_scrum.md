---
date: 2017-07-10
category:
 - scrum
 - leadership
 - management
slug: practical-scrum-for-agile-teams
---
# Practical scrum for agile teams
In this blog, I introduce the concept of scrumming, which is used widely by agile software development teams. I draw upon my introspections of practicing scrum for 3 years.

<!-- more -->


## Table of contents
- [Misconceptions](#misconceptions)
- [What is scrum?](#what-is-scrum)
	- [History of scrum](#history-of-scrum)
	- [Core tenets of scrum](#core-tenets-of-scrum)
- [The scrum framework](#the-scrum-framework)
	- [4 formal scrum events](#4-formal-scrum-events)
	- [Roles in a scrum](#roles-in-a-scrum)
		- [Scrum team](#scrum-team)
		- [Product Owner \(PO\)](#product-owner-po)
			- [PO responsibilities](#po-responsibilities)
		- [Development team](#development-team)
		- [Scrum Master \(SM\)](#scrum-master-sm)
	- [Management tools and metrics in scrum](#management-tools-and-metrics-in-scrum)
		- [Product backlog](#product-backlog)
		- [User stories \(PBIs\)](#user-stories-pbis)
		- [Tasks](#tasks)
		- [Epics](#epics)
		- [PBI estimates](#pbi-estimates)
		- [Sprint velocity](#sprint-velocity)
		- [The burn down chart](#the-burn-down-chart)
- [Using scrum to plan your projects](#using-scrum-to-plan-your-projects)
- [Lessons learned](#lessons-learned)

## Misconceptions
What scrum is not? - not just a software development process. It is independent of industry, in fact can be applied even in your household.

Scrum is not all about the stand-up meetings - although that is sometimes trademark of teams that follow scrum. The stand up meetings is a means to improve communication and camaraderie through regular in-person or video conference meetings.

## What is scrum?
It's a framework for teams that want to be self-organizing, agile and adapt quickly to changing requirements and deliver in short manageable time line.

It is surprising to observe even how considerably large projects can be broken down into smaller pieces and delivered in half or quarter of the projected time and expense by adopting scrum methodology.

### History of scrum
Founded on empirical process control theory or empiricism, scrum believes knowledge comes from experience and emphasizes on making decisions based on what is known. Scrum employs iterative, incremental approach to improve predictability and control risk. There are 3 important principles of empirical process control theory:
 - Transparency - a common metric to measure progress and a shared definition of done
 - Inspection - regular and frequent inspection of progress is required. But inspection should never get in the way of work or stop or modify the project.
 - Adaptation - if inspection leads to a discovery of something in deviation then an adjustment should be made at the earliest.

### Core tenets of scrum
Let us look at a few process management techniques that take a systems approach to understand where scrum fits in:
 * **Lean** - The goal of lean is simple: minimize the time between customer request and fulfillment by continually improving and reducing non-value adding work.
 * **Agile** - Uses business value as primary measure of progress. Reduces risk through continuous delivery
 * **Scrum** - a wrapper around agile and is a process to practice agile delivery / development. Scrum is industry and technology agnostic.

In this light, it is relevant to discuss about the key points of the Agile manifesto: An agile process values:
 - **Individual and interactions** over processes and tools. Teams are self-organizing and self-solving all the way. Teams are self-contained as they figure out what to do and also how to do.
 - **Working software** over detailed doc explaining the eccentricities and caveats while using the product. Customers pay for value, which should be provided by the main product and not by a bunch of explanations about the product. Scrum lays emphasis on developing a 'definition of done' and arriving at a consensus with the customer / stakeholder. This `done` definition could be such that 
 - **Customer collaboration** over contract negotiation. Most successful businesses attribute their success to one thing - listening and providing what the customer wants. This can be achieved only involving the customer / stakeholder not only in the beginning but also at regular intervals during the development life cycle.
 - **Responding to change (agile)** over following a process. In today's world with increased access to real-time information in all fronts, companies can continue to remain on top only by embracing change and adapting to it. This means, as your customers constantly adapt to change, so do you. By delivering working software in increments and but periodically collaborating with the customer, scrum helps you to be agile to these changes. As needs change, your development team can change trajectory without much losses or overheads. 

## The scrum framework
Now, we are getting into the details of scrum. Let us visit some concepts about scrum that will help us better understand how to adopt it:

### 4 formal scrum events
Although scrum encourages daily stand-up meetings, it discourages longer more formal events. It recommends each team to organically figure out at what frequency they meet and for how long they discuss. Having said, below are four formal events that scrum teams practice:
 - sprint planning - a meeting where the entire team plans the work to be done during that sprint / iteration
 - daily scrum - a short daily meeting where entire team takes stock of work done the previous day
 - sprint review - a meeting toward the end of the sprint where the product delivered incrementally is visited and reviewed.
 - sprint retrospective - another meeting toward the end of the sprint with emphasis on interpersonal relationships, productivity where the team discusses their development methodology, impedances and figure what can be improved.

### Roles in a scrum
Scrum believes in teams composed of multi-disciplinary and cross-functional team members such that all the talent and skills required to finish the product are self-contained within the team. As product complexities grow, inevitably each of your team members start becoming subject matter experts specializing in a narrow functional area. Yet this introduces a unique risk in the form of single point failure. Thus scrum encourages developing a healthy mix of multi-disciplinary team members who are sufficiently acquainted in areas other than their own. Some managers call these as T members (since their spread both horizontally and also vertically). Thus whenever a shortage of resource or skill set arises, the existing team can expand and fulfill the gap without immediately becoming brittle. In this light, each of the team member fit into one of the following roles:

#### Scrum team
A team consists of 
 - product owner
 - development team
 - scrum master

Scrum teams are self organizing - they decide how to work on things without external direction, cross functional - have all competencies to finish the project without relying on other teams

#### Product Owner (PO)
Manages product backlog (more on this later) - furnishing with details, prioritizing it, exposing it to all team members.

Only the PO has the right to change the backlog and the entire organization must respect this decision. The development team works from this backlog and no one can inject a different set of requirements bypassing the PO.

##### PO responsibilities
 - Manage profitability and ROI (return on investment). A PO does this by prioritizing the backlog to maximize the business value delivered. To start with, the PO must arrive at a way to determine the value delivered, a metric of sorts
 - Call for releases. PO decides what constitutes a minimum shippable product. PO also has liberty to move the release time line forward or backward to maximize the ROI.
 - Guides product development. PO would establish, nurture and communicate the vision. Knows what to build and in what sequence (note, how to build is not a requirement for PO. The development team figures this out).

#### Development team
This amazing team is self organizing, not even the scrum master tells how to turn the backlog into products. Scrum calls **everyone a developer** no matter the work performed by the person. No sub teams can exist within a scrum team. 3-9 is a valid team size not including PO and SM unless they also act as development team.

#### Scrum Master (SM)
Ensure scrum is understood and practiced. SM plays a **servant-leader** role in helping teams be self organizing and helping PO with backlog grooming, arrangement, interfacing with external influencers etc. The scrum master usually drives the team meetings.

### Management tools and metrics in scrum
Scrum provides a set of tools, terms and metrics to organize and manage your project. Let us visit them briefly here:

#### Product backlog
The backlog contains the list of all requirements. Each item (a PBI - product backlog item) in the backlog is written as a **user story**. The PO prioritizes the backlog and arranges the items in the order in which it has to be finished. The order of backlog should maximize the ROI.

#### User stories (PBIs)
Each PBI is written as a user story. User stories are of format:

 	As a <role>,
 	I can <feature / function>,
 	so that <goal / value>.

For example, the user story for backup camera in a car can be written as
	
> As a driver, I can use the back up camera when I am reversing the car so I can see what's behind the car more clearly than what my rear view mirrors show.

What is management without acronyms :) Lets throw one for user stories.. A user story is good if its INVESTable: Independent, Negotiable, Valuable, Estimatable, Small and Testable. Resist from writing a user story until you have a clear understanding of what you are building.

#### Tasks
Each PBI written as a user story will have a set of clearly defined tasks which need to be finished to call that PBI `done`. The scrum master encourages the team to come up with a definition of done. This definition can vary slightly between each PBI. The purpose of this definition to establish and maintain the quality of the product being delivered over several sprints.

Tasks are usually technical in nature and they are collectively created as a team during the scrum planning meeting.

#### Epics
When a bunch of user stories come together, they form an epic. Consider an epic as a large feature that is composed of many sub features that together make a functionality complete and usable. In the case of the backup camera we user story we visited earlier, an epic would be a collection of few more user stories such as:

Backup camera Epic:

1. Turn on back up camera when put in reverse
2. Enhance back up camera feed with steering predictors / guides
3. Alert with audio and steering wheel vibrators when a moving object is detected in back up camera feed
4. Alert lane departures using back up camera feed.

Next, let us discuss about some metrics to quantify and estimate progress of a scrum team.

#### PBI estimates
Scrum believes in breaking down your product releases (or epics) into smaller identical building blocks called PBIs. No matter how you try, not all of your PBIs would be of identical nature in terms of complexity and effort. Further, some of your PBIs may be diagonally opposite that they may nothing in common. Some of your PBIs may be so new to everyone in your team that nobody knows exactly how to finish it. Then how do you compare and estimate their effort, provide a delivery date and bill the customer?

One way to estimate is treat the PBIs as abstract entities and judge them relative to one another in terms of time or effort required to finish them. As a team, during the sprint planning meeting you sort arrange the PBIs in ascending order of effort involved. It is much easier to compare a PBI against another PBI which your team has completed and evaluate comparatively if it requires the same time, lesser or greater time. Then you assign effort in abstract terms such as T shirt sizes (S, M, L, XL, XXL, ..) or Fibonacci number sequence (1, 2, 3, 5, 8, 13 ..).

Thus, in the backup camera example from earlier, a team may evaluate

1. Turn on back up camera when put in reverse --> **S or 2**
2. Enhance back up camera feed with steering predictors / guides --> **M or 3**
3. Alert with audio and steering wheel vibrators when a moving object is detected in back up camera feed --> **L or 5**
4. Alert lane departures using back up camera feed. --> **M or 3**

Time and effort estimation are much accurate as long as you work with smaller numbers (S, M or 1, 2, 3 ..) and they get fuzzy and uncertain once they go beyond 8 or XL size. If you find yourself with PBIs that are in larger end of effort spectrum, try to break it into smaller pieces.

Since you write the PBIs as user stories, the PBI estimates are also called as `story points`.

#### Sprint velocity
Once you start to quantify your PBIs with story points, you can calculate how much you manage to finish during a sprint. Remember, a PBI is considered finished only after it meets the `definition of done` explained earlier. This number which is the sum of finished PBI story points is your sprint velocity.

In the backup camera example, if your team finishes the first two PBIs in a sprint, then your `velocity` is `2 + 3 = 5`. If your sprint consisted of 3 weeks then you may understand that is the time required for finishing an effort 5.

Just like the story points, the velocity is highly subjective to each team. Two scrum teams cannot compare their velocities since it is arbitrary in nature. However, the velocity is a useful metric as it allows you to estimate how many PBIs can be completed in a typical sprint.

From the example above, if your sprint velocity is a `5`, then you may estimate that you need a minimum of `2` more sprints to finish the remaining 5 and 3 story point PBIs. Once that epic is finished, the PO can call for a release cycle and release the full product.

#### The burn down chart
Now that you have enough metrics to play with, you can create a chart to visualize them. Simply plot the time (perhaps in the form of sprints) in X axis and PBI story points for an epic in the Y axis. Next plot your the velocity for each sprint as a line chart, you get yourself a burn down chart.

![Burn down chart pic](https://en.wikipedia.org/wiki/Burn_down_chart#/media/File:SampleBurndownChart.png)

The chart helps you to inspect the pace and estimate when the epic would get done. You can take precautionary measures if you anticipate requiring more time.

## Using scrum to plan your projects
Now that you are familiar with the terminologies and tools involved, let us review how to apply them in project management. In the agile management approach, you plan for releases in three levels. 

 1. First is the `release plan`. Here, you arrange the PBIs and or epics in the order of importance or value. The PO takes a call on what to include and what to leave out. All the PBIs go into the product backlog list.
 2. Each release is composed of one or more `sprints`. A sprint is a short two to three week period where the entire scrum team comes together, works on one or two PBIs and finishes it. During the `sprint planning` meeting, the scrum master coaches the development team to work with the PO and pick the PBIs they want to finish during that sprint. These PBIs enter the `sprint backlog`.
 3. During the sprint, the team meets for a short 15 min stand-up meeting where each member states what they worked on, plan to work and if they have anything impeding their progress. The scrum master takes responsibility to clear these impedences. The product owner clarifies any questions the team has.

At the end of the sprint, in a `sprint review` meeting the team demonstrates the finished product increment to the stake holders and get their sign off. This is also a chance for the stake holders to request for new features or modify the goal of the project based on changing market needs. If such a case arises, the product owner adds them to the product backlog. At no cost can the stake holders interfere a scrum team during a development cycle.

Also at the end of the sprint, the team convenes for a `sprint retrospective` to discuss how the iteration went, what can be improved or changed. The team either proceeds to or reconvenes to plan the next sprint in a `sprint planning` meeting. The cycle repeats with the team working with product owner to pick the PBIs they want to finish in that sprint cycle and so on.

Over this course, each team member have clearly defined roles and know what they are responsible for. The product owner continues to interface with the stake holders, get new requirements, keep the product backlog organized and prioritized by business value. The scrum master continues to perform the servant-leader role and coaches the team toward peak performance. The SM ensures the team is safe from external disturbances or injection of work items. The development team continues make progress by working on as few PBIs possible at a time as a team. They finish the PBIs to meet the `done` specification before proceeding to work on a new PBI. If a task is left undone, the team members feel free to grab it and work on it. There is no ownership of duties, but there is ownership of the product as a whole.

# Lessons learned
 1. Don't compare velocities between teams
 2. your velocity will change as members are added or removed from your team
 3. velocity changes seasonally as your members go on vacations, fall sick, or other tasks impede them
 4. when you break a larger PBI down to smaller ones, you almost always realize they break down into larger than expected pieces. For instance, I have noticed, breaking a 8 will not simply yield a 5 and 3 story point PBI, but often into two 5s or if we are lucky into three 3s. This is not bad, since it benefits you to over estimate time required than otherwise.

