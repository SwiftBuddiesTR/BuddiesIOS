if [ "${CONFIGURATION}" != "Debug" ]; then
     "Tuist/Dependencies/SwiftPackageManager/.build/checkouts/firebase-ios-sdk/Crashlytics/run" "Tuist/Dependencies/SwiftPackageManager/.build/checkouts/firebase-ios-sdk/Crashlytics/upload-symbols" -gsp ./Resources/GoogleService-Info.plist -p ios ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}
fi
