Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41836 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755446Ab2F3QRl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 30 Jun 2012 12:17:41 -0400
Received: by eeit10 with SMTP id t10so1664145eei.19
        for <util-linux@vger.kernel.org>; Sat, 30 Jun 2012 09:17:40 -0700 (PDT)
Message-ID: <4FEF26A0.3010901@gmail.com>
Date: Sat, 30 Jun 2012 17:17:36 +0100
From: Iain Paton <selsinork@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: problem with script -e
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Came across an unexpected feature with script today. Can't make my mind up if 
it's a bug or not, but it certainly makes some things difficult.

Easy to reproduce, as follows

1. create a shell script with the following contents

#!/bin/bash
sleep 5
exit 42

2. run it under script

$ time script -e -c ./tst.sh ; echo $?
Script started, file is typescript
Script done, file is typescript

real    0m5.320s
user    0m0.020s
sys     0m0.008s
42

results as expected..


3. make it fail

$ time script -e -c ./tst.sh < /dev/null ; echo $?
Script started, file is typescript
Script done, file is typescript

real    0m0.012s
user    0m0.004s
sys     0m0.003s
0

The script still runs in a forked process, the parent has just exited early.

You can redirect just about anything as stdin for script and get the same 
problem, doesn't have to be /dev/null.

Ok, so if I want to redirect a file into the thing running under script there's 
probably other ways to do it, but still.

I stumbled across this while trying to capture the output of something being 
ran remotely by a daemon where there's no controlling tty, stdin/stdout/stderr 
are all redirected to /dev/null and the scripts return code is being checked.

Run it normally and an error is logged, try running it under script to find 
out some details of the error and of course there's no error logged... 
At least until you look at the output.

Tracked it down to the doinput function that deals with read(STDIN_FILENO...
being greater than zero or less than zero, but if it returns 0 for EOF then it 
ignores the die == 0 condition and exits.
Seems that there's an implicit assumption that stdin will always be a tty for 
the script process - strace shows all sorts of -ENOTTY stuff when it's not.

I came up with the following that works for my use case, but maybe there's a 
better way ?

--- script.c.org	2011-08-29 09:31:19.000000000 +0100
+++ script.c	2012-06-30 16:24:42.896997422 +0100
@@ -295,18 +295,29 @@
 
 	fclose(fscript);
 
-	while (die == 0) {
-		if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
-			ssize_t wrt = write(master, ibuf, cc);
-			if (wrt < 0) {
-				warn (_("write failed"));
-				fail();
+	if(isatty(STDIN_FILENO)) {
+
+		while (die == 0) {
+			if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
+				ssize_t wrt = write(master, ibuf, cc);
+				if (wrt < 0) {
+					warn (_("write failed"));
+					fail();
+				}
 			}
+			else if (cc < 0 && errno == EINTR && resized)
+				resized = 0;
+			else
+				break;
+		}
+	} else {
+	
+		while(die == 0) {
+			
+			fd_set fs;
+			FD_ZERO(&fs);
+			select(1, &fs, &fs, &fs, NULL);
 		}
-		else if (cc < 0 && errno == EINTR && resized)
-			resized = 0;
-		else
-			break;
 	}
 
 	done();




