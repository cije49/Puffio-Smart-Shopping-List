allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Namespace patch — must run BEFORE evaluationDependsOn below
subprojects {
    afterEvaluate {
        if (hasProperty("android")) {
            extensions.findByName("android")?.let { ext ->
                val androidExt = ext as com.android.build.gradle.BaseExtension
                if (androidExt.namespace == null) {
                    androidExt.namespace = group.toString()
                }
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}