allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Redirect build directory only for projects on the SAME drive root
// to avoid cross-drive path resolution errors on Windows.
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Only redirect build dir for subprojects that share the same drive root
    val projectDir = project.projectDir.absolutePath
    val rootDir = rootProject.projectDir.absolutePath
    if (projectDir.take(1).equals(rootDir.take(1), ignoreCase = true)) {
        val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
        project.layout.buildDirectory.value(newSubprojectBuildDir)
    }
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
