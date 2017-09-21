Return-Path: elseifthen@gmx.com
Subject: [PATCH 1/2] Docs: grammar fixes for v2.31-ReleaseNotes
To: Karel Zak <kzak@redhat.com>
References: <20170920093910.topplypo723gwper@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <2dd09cc6-9edb-1e94-5874-918ee46d53e2@gmx.com>
Date: Wed, 20 Sep 2017 21:18:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170920093910.topplypo723gwper@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---

Karel, are you interested in these types of grammar/spelling/whitespace
fixes for releasenotes? If not, I won't spend time on them. Note: I only
had time to review and update the 'highlights' section.

 Documentation/releases/v2.31-ReleaseNotes | 58 +++++++++++++++----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/releases/v2.31-ReleaseNotes b/Documentation/releases/v2.31-ReleaseNotes
index 4671838b1..bc0c6f4ea 100644
--- a/Documentation/releases/v2.31-ReleaseNotes
+++ b/Documentation/releases/v2.31-ReleaseNotes
@@ -3,69 +3,69 @@ Util-linux 2.31 Release Notes
 
 The package build-system follows GNU Coding Standards and uses --runstatedir
 instead of --localstatedir. The default is /run. Please, review your distribution
-build scripts (spec files etc.) to be sure that this change does not introduce 
-any regression to your distribution. 
+build scripts (spec files etc.) to be sure that this change does not introduce
+any regression to your distribution.
 
 
 Release highlights
 ------------------
 
 rfkill -- NEW COMMAND for enabling and disabling wireless devices. This new
-implementation is based and backwardly compatible to the original rfkill from
-Johannes Berg and Marcel Holtmann.
+implementation is based upon, and backward compatible with, the original rfkill
+from Johannes Berg and Marcel Holtmann.
 
 The command su has been refactored and extended to create pseudo terminal for
 the session (new option --pty). This new EXPERIMENTAL feature provides better
-isolation between root's terminal and unprivileged su session.
+isolation between root's terminal and an unprivileged su session.
 
-uuidparse -- NEW COMMAND to provide details about types, variants and time
-hashed to the UUID.
+uuidparse -- NEW COMMAND to provide variant and type details for input UUIDs.
 
 The library libuuid and command uuidgen support hash-based UUIDs v3 (md5) and
 v5 (sha1) as specified by RFC-4122. The library also provides UUID templates
 for dns, url, oid, or x500.
 
 The library libblkid has been extended to support DM-integrity, HPE (aka
-extended-XFS) and UBI superblock. The library also provides new API to hide
-already detected signatures. This allows to gather all possible magic strings
-permutation for the device, and for example command wipefs prints complete list
-of all magic strings now.
+extended-XFS) and UBI superblock. The library also provides a new API to hide
+already detected signatures. This allows the gathering of all possible magic
+string permutations for a device. For example, the command wipefs will now print
+the complete list of all magic strings.
 
 The library libfdisk provides a new API to modify grain (a size used for
-partitioning calculation) and it is also possible to completely disable dialog
+partition calculations) and it is also possible to completely disable dialog
 driven partitioning.
 
 The library libsmartcols provides a new API to move columns. This new
-functionality is avaialable by "column --table-order" on command line.
+functionality is available by "column --table-order" on the command line.
 
-The command "column --table-header-repeat" allows to repeat table header
+The command "column --table-header-repeat" allows repetition of table headers
 according to terminal size.
 
-The libfdisk has been extended to use BLKPG ioctls to inform kernel about
-changes. It means that cfdisk and fdisk do not force kernel to reread all
-partition table, but untouched partition may remain mounted and used by system.
-Tne typical use-case is resize last partition on system disk.
+The libfdisk has been extended to use BLKPG ioctls to inform the kernel about
+changes. This means that cfdisk and fdisk will not force the kernel to reread
+all of the partition table, but untouched partitions may remain mounted and used
+by the system. The typical use-case is resizing the last partition on the system
+disk.
 
 The command cfdisk provides a new dialog to resize a partition.
 
 The fdisk menu behavior on ^C and ^D has been improved to stop the current
-operation and return to main menu rather than immediately terminate all fdisk
+operation and return to main menu rather than immediately terminating the fdisk
 program.
 
-The command look follows WORDLIST environment variable (if specified) to 
-find word list.
+The 'look' command now follows the WORDLIST environment variable (if specified)
+to find the word list.
 
-The almost all --help and --version outputs have been improved (thanks to
+Almost all of the --help and --version outputs have been improved (thanks to
 Ruediger Meier and others).
 
-The command script has been improved to follow usual semantic for stop/continue
-signals. It's possible to move all session to the background and later back to
-the foreground (e.g. shell command "fg", etc.).
+The 'script' command has been improved to follow the usual semantics for
+stop/continue signals. It's possible to move a session to the background and
+later back to the foreground (e.g. shell command "fg", etc.).
 
-The command setpriv supports ambient capabilities with new command line option
---ambient-caps (thanks Patrick Steinhardt) and the new command line option
---init-groups allows to initialize supplementary groups (thanks to Sebastian
-Schrader).
+The setpriv command now supports ambient capabilities with the new command line
+option --ambient-caps (thanks Patrick Steinhardt) and the new command line
+option --init-groups allows initialization of supplementary groups (thanks to
+Sebastian Schrader).
 
 
 Security issues
