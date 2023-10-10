Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD832CD98C4
	for <util-linux@archiver.kernel.org>; Tue, 10 Oct 2023 21:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjJJVSw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Oct 2023 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjJJVSv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Oct 2023 17:18:51 -0400
X-Greylist: delayed 130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 14:18:48 PDT
Received: from pl1.haspere.com (pl1.haspere.com [209.177.156.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636A91
        for <util-linux@vger.kernel.org>; Tue, 10 Oct 2023 14:18:48 -0700 (PDT)
Received: from roomba.dyweni.com (localhost [127.0.0.1])
        by pl1.haspere.com (Postfix) with ESMTP id A47762B417;
        Tue, 10 Oct 2023 16:16:37 -0500 (CDT)
MIME-Version: 1.0
Date:   Tue, 10 Oct 2023 16:16:37 -0500
From:   Dyweni - Util-Linux <DDh8rwTFp32E@dyweni.com>
To:     util-linux@vger.kernel.org
Subject: Unexpected interaction between script and screen
Reply-To: DDh8rwTFp32E@dyweni.com
Mail-Reply-To: DDh8rwTFp32E@dyweni.com
Message-ID: <b6a590f6024faea4c2b738a70774bc47@dyweni.com>
X-Sender: DDh8rwTFp32E@dyweni.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi All,

I'm running into an issue with the interaction between 'script' and
'screen' whereby the active/focused session inside 'screen' is
unexpectedly terminated when the SSH connection is lost.  See below for
examples of this without running script, with script and one screen
session, and with script and multiple screen sessions).

I'm using 'script' to log/record all activity and is started
automatically via a bashrc script.

I've tracked the problem down to 'ul_pty_proxy_master()' where it calls
'ul_pty_write_eof_to_child()' which sends CTRL-D to the child.  This
in-turn gets passed through 'screen' to the inner 'script' and child
processes.  The real immediate child (the bash shell that started
'screen') is never closed.

What can be done so that outer 'script' and associated processes are
terminated/cleaned up, while leaving the screen server and all of it's
sessions unaffected?  Maybe add an option to 'script' so that it kills
the immediate child process instead of sending CTRL-D to it?

Thank you!


====> Using normal ssh/screen <====

-- before ssh connection loss --
24469  \_ sshd: root@pts/3
24474  |   \_ -bash
24482  |       \_ screen
24483  |           \_ SCREEN
24484  |               \_ -/bin/bash

-- after ssh connection loss --
24483 SCREEN
24484  \_ -/bin/bash

-- actuan/expected result --
The session running inside screen stays running and the session that
started screen is properly terminated/cleaned up.


====> Using ssh/script/screen/script (With one screen session) <====

-- before ssh connection loss --
25180  \_ sshd: root@pts/1
25183  |   \_ -bash
25191  |       \_ script -f 25183.3119.log
25192  |           \_ bash -i
25206  |               \_ screen
25207  |                   \_ SCREEN
25208  |                       \_ -/bin/bash
25217  |                           \_ script -f 25208.26983.log
25218  |                               \_ bash -i

-- after ssh connection loss --
25191 script -f 25183.3119.log
25192  \_ bash -i

-- actual result --
The session running inside screen is shutdown, sshd and screen (both the
client [pid 25206] and the server [pid 25207]) are terminated, but the
outer script remains running.

-- expected result --
The session that started screen (the sshd process, the immediate child
script, and the screen client [pid 25206]) should have been terminated/
cleaned up, leaving the screen server [pid 25207] and all sessions
intact.



====> Using ssh/script/screen/script (With two screen sessions) <====

-- before ssh connection loss --
25907  |   \_ -bash
25915  |       \_ script -f 25907.11974.log
25916  |           \_ bash -i
25930  |               \_ screen
25931  |                   \_ SCREEN
25932  |                       \_ -/bin/bash
25940  |                       |   \_ script -f 25932.2808.log
25941  |                       |       \_ bash -i
25953  |                       \_ -/bin/bash
25961  |                           \_ script -f 25953.19131.log
25962  |                               \_ bash -i

-- after ssh connection loss --
25915 script -f 25907.11974.log
25916  \_ bash -i
25930      \_ screen
25931          \_ SCREEN
25932              \_ -/bin/bash
25940                  \_ script -f 25932.2808.log
25941                      \_ bash -i

-- actual result --
The active session running inside screen is shutdown but screen remains
running due to the other sessions which were running.  The sshd process
is terminated but the outer script remains running.

-- expected result --
The session that started screen (the sshd process, the immediate child
script, and the screen client [pid 25930]) should have been terminated/
cleaned up, leaving the screen server [pid 25931] and all sessions
intact.

