set(NAME Hello_World)

fiLE(GLOB_RECURSE SRC
"*.cpp"
)

add_executable(${NAME}
${SRC}
)