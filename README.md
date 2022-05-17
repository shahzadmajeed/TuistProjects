# Issue
Unable to get default resource synthesizers behavior for local swift packages. 


# How to reproduce?
1. Run `tuist fetch`
2. Run `tuist generate`
3. Notice that `Feature1` framework in generated project `SPMModules` will not contain `Assets+Feature1.swift`, `Strings+Feature1.swift`
4. App target `Workbench` which is **NOT** a local swift target generates `Assets+Workbench.swift`, `Bundle+Workbench.swift` and `Strings+Workbench.swift` correctly

# Expected result?
`Feature1` framework in generated project `SPMModules` should contain `Assets+Feature1.swift`, `Strings+Feature1.swift` for assets & strings via default resource synthesizers
		


