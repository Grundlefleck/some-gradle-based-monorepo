## Gradle-based Monorepo with efficient CI/CD pipeline

Purpose: investigate and demonstrate how to set up a Gradle-based monorepo with an "efficient" Continuous Integration / Continuous Delivery pipeline. 

Where "efficient" means "only builds what it needs to". In a monorepo with several projects, it is wasteful to build all of project Foo's pipeline if there were only changes in project Bar, and there's no dependency between the projects.

This is an effort to replace an extremely flawed approach I currently use, which involves: git changelists; bash shell scripts; and Jenkins plugins designed for entirely different purposes.

### Requirements 
As well as being efficient, other requirements include:
 
 * correct and precise dependency resolution, when deciding what pipelines to build
 * requires defining dependencies at most once, no duplication
 * can provide a monotonically increasing version number, for human-readable artifact versioning
 * build pipelines must be able to execute distinct steps on different nodes

 
 ### Software constraints
 The repository is hosted in the git VCS built by Gradle. The build pipeline being run on Jenkins is preferable, but not strictly necessary, as long as the CI/CD tool can integrate with an existing Jenkins install to either receive or send pipeline triggers or results.

### Monorepo characteristics
This hypothetical source code repository contains the source code for a typical web-based SaaS application, that can be built and delivered continuously. There are many distinct applications within this repository, which can be built and deployed independently. Shared code can be placed in a separate subproject, and incorporated in the other applications and libraries that depend on it. 

### Continuous Integration
Libraries and applications contain different testing strategies: 
 * unit testing, with no external dependencies
 * static analysis, has no external dependencies, may be slower, and some aspects may be non-critical, in some cases, not blocking the build pipeline
 * security analysis, a kind of static analysis, but critical enough to block the build pipeline
 * integration testing, requires external services like a database or other application process
 * browser testing, requires external resources such as worker nodes to drive a browser-testing framework, may need to deploy and start the application
 * monitoring tests, requires a client and network access to exercise a deployed application

### Continuous Delivery
Applications are deployed using an internal/third-party tool. The third-party tool need not be embedded within the CI/CD environment, as long as it can be invoked, and success or failure is reported. Deployments can be automatic, or manual, but they should be idempotent with respect to an application version.