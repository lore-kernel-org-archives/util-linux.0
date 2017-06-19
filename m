Return-Path: elseifthen@gmx.com
Subject: [PATCH 10/12] Docs: update howto-usage-function.txt
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <826b3038-077e-97e2-4e97-65c793acc8fd@gmx.com>
Date: Sun, 18 Jun 2017 20:48:34 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/howto-usage-function.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index 54d3084..8da8deb 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -10,8 +10,7 @@ other purpose:
 The rule of thumb with other options is that once they exist, you may
 not change them, nor change how they work, nor remove them.
 
-Notice that '-?' is not expected to be a synonym of '--help', but is an
-unknown option resulting in a usage print-out due to a getopt failure.
+See Legacy options below.
 
 
 How a usage text is supposed to look
@@ -118,6 +117,7 @@ entail for translators will pay off later, at the time of the next change,
 when they will not need to search in the long fuzzy text what was changed,
 where, how, and whether it was the only change.
 
+
 Synopsis
 --------
 
@@ -143,13 +143,15 @@ Some commands use peculiar options and arguments.  These will continue
 to be supported, but anything like them will not be accepted as new
 additions.  A short list of examples:
 
-- Other characters than '-' to start an option.  See '+' in 'more'.
-- Using a number as an option argument.  See '-<number>' in 'more'.
+- Characters other than '-' to start an option.  See '+' in 'more'.
+- Using a number as an option.  See '-<number>' in 'more'.
 - Long options that start with a single '-'.  See 'setterm'.
+- '-?' is not expected to be a synonym of '--help', but is an unknown
+  option resulting in a suggestion to try --help due to a getopt failure.
 
 
 Example file
 ------------
 
-The file disk-utils/delpart.c is a minimal example of how to write
+The file ./boilerplate.c is a minimal example of how to write
 a usage function, set up option parsing, version printing and so on.
