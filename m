Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:50981 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932994AbcCGXMI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Mar 2016 18:12:08 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MMBiP-1aVerz0KNx-007zNL for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 00:12:06 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/12] tests: getopt2, add function gnu_getopt_clean()
Date: Tue,  8 Mar 2016 00:12:00 +0100
Message-Id: <1457392322-4974-11-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
References: <1457392322-4974-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This makes the test compatible to OpenBSD, OSX and musl libc.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/misc/getopt2 | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/ts/misc/getopt2 b/tests/ts/misc/getopt2
index 779d15b..8ca2d55 100755
--- a/tests/ts/misc/getopt2
+++ b/tests/ts/misc/getopt2
@@ -22,104 +22,136 @@ ts_check_test_command "$TS_CMD_GETOPT"
 
 export LANG=C
 
+function gnu_getopt_clean() {
+	sed --in-place \
+		-e "s/: \(.*\) -- \(.\)$/: \1 -- '\2'/" \
+		-e "s/ ['\`]\(--[a-zA-Z0-9]\{1,\}\)'/ '\1'/g" \
+		-e "s/unrecognized option: \(.\)$/invalid option -- '\1'/" \
+		-e "s/option requires an argument: \(.\)$/option requires an argument -- '\1'/" \
+		-e "s/unrecognized option: \([^'-].\{1,\}\)$/unrecognized option '--\1'/" \
+		"$TS_OUTPUT"
+}
+
 ts_init_subtest alternative_option_clash
 $TS_CMD_GETOPT -a -o abcde -l abcde -- -a -ab -abc -ac >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest alternative_option_long
 $TS_CMD_GETOPT --alternative -o a -l one,two:,three::,four:: -- -a -one -two=MANDATORY -three=OPTIONAL >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest alternative_option_short
 $TS_CMD_GETOPT -a -o a -l one,two:,three::,four:: -- -a -one -two=MANDATORY -three=OPTIONAL >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest invalid_getopt_option
 $TS_CMD_GETOPT -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i '1,1s/.*\///' $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest invocation_model_one
 $TS_CMD_GETOPT abc:d::e::f::g: ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest invocation_model_three_as_one
 $TS_CMD_GETOPT -o abc:d::e::f::g: -- ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest invocation_model_two_as_one
 $TS_CMD_GETOPT -- abc:d::e::f::g: ARG0 -b ARG1 -d -eOPTIONAL1 -f NOT_OPTIONAL ARG2 -a -c -ISREQUIRED ARG3 -g "BECOMES THREE ARGUMENTS" >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest invocation_without_parameters
 $TS_CMD_GETOPT >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest long_option_ambiguous_1
 $TS_CMD_GETOPT -o a -l long1,long2 -- --long >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i -e '1,1s/.*\///' -e "1s/ambiguous$/ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
+sed -i -e "1s/is ambiguous: long$/'--long' is ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest longopts
 $TS_CMD_GETOPT -o a -l long1,secondlong:,thirdlong::,abbriviation: -- --long1 EXTRA1 --thirdlong=ARGUMENT --secondlong=ARG --abbr ABBRARG -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest name_option_long
 $TS_CMD_GETOPT -n THIS_PROGRAM -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest name_option_short
 $TS_CMD_GETOPT --name THIS_PROGRAM -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest quiet_option_long
 $TS_CMD_GETOPT --quiet -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest quiet_option_short
 $TS_CMD_GETOPT -q -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest quiet_output_option_long
 $TS_CMD_GETOPT --quiet-output -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i -e '1,4s/.*\///' -e "3s/ambiguous$/ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
+sed -i -e "3s/is ambiguous: long$/'--long' is ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest quiet_output_option_short
 $TS_CMD_GETOPT -Q -o a,b: -l long1,long2 -- -c --unknown --long -b >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i -e '1,4s/.*\///' -e "3s/ambiguous$/ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
+sed -i "3s/is ambiguous: long$/'--long' is ambiguous; possibilities: '--long1' '--long2'/" $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest same_long_short_options
 $TS_CMD_GETOPT -o a -l a -- -a --a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest test_for_enhanced_getopt
 $TS_CMD_GETOPT -T >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest unknown_options
 $TS_CMD_GETOPT -o a -l long -- -b --long --whatever -a >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
 sed -i '1,2s/.*\///' $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest unquoted_option_bash
@@ -128,6 +160,7 @@ $TS_CMD_GETOPT -s bash -u -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
 one
 line' >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest unquoted_option_tcsh
@@ -136,6 +169,7 @@ $TS_CMD_GETOPT -s tcsh --unquoted -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'M
 one
 line' >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest weird_quoting_bash
@@ -144,6 +178,7 @@ $TS_CMD_GETOPT -s bash -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
 one
 line' >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_init_subtest weird_quoting_tcsh
@@ -152,6 +187,7 @@ $TS_CMD_GETOPT --shell tcsh -o a: -l long1: -- -a '$?!* ' --long \"\\\' 'More
 one
 line' >> $TS_OUTPUT 2>&1
 echo "exit value: $?" >> $TS_OUTPUT
+gnu_getopt_clean
 ts_finalize_subtest
 
 ts_finalize
-- 
1.9.1

