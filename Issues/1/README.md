# Goal
We want to develop multiple `.app` tuist projects `Project.swift` where each project will mostly contain just one single `.app` target (probably companion testing targets as well). 

Each `.app` project will depend on a local swift package with multiple products so that most of our code stays in local swift packages and tuist only generates & maintains apps i.e `.app` projects. This strategy will not only allow us to spin up mutliple apps quickly but also have a quick backup in-place just in case we don't want to use tuist anymore (I hope everyone in my team will love tuist and we will keep using it).

# Issue
Unable to get default resource synthesizers behavior for local swift packages. 

1. Currently, I only have one `.app` project `Project.swift` which is using a single local swift package
2. When I run `tuist generate` on `Workspace.swift` tuist generates 2 projects and open them in workspace
3. Let's say project `A` is for my `.app` and project `B` is for local swift package
4. Project `B` doesn't contain resource accessors for `assets`, `strings` and `files`. It only contains `bundle` files in `Derived` folder

# Project Structure
__`TuistProjects/Issues/1/`__

* **Projects**: directory that contains 
	* Sample app project `Workbench` 
		* `.app` & 2 additional frameworks to show tuist generates resources synthesizers for these frameworks correctly
	*  	Local swift package `Thor`
		*  Single target products, some of them contain assets, XIB and/or localized strings. Tuist doesn't generate resource accessors for these
* **ThorTestApp/ThorTestApp**: A separate app that is not a tuist project. Just for experimentation to see same code is working in non-tuist project. No real use for now
* **Tuist**: Tuist integration i.e, configuration, helpers, dependencies etc.
* **Workspace.swift**: Tuist workspace `"Metaverse-iOS` that points to the only project `Workbench`

# How to reproduce?
1. Run `tuist fetch`
2. Run `tuist generate`
3. Notice that project `Thore` will not contain `Assets+Styles.swift`, `Strings+Styles.swift`
4. Same happens to other local package targets that contain some resources
		


