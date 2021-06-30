set(NAME hello)

fiLE(GLOB_RECURSE SRC
"*.cpp"
)

add_executable(${NAME}
${SRC}
)