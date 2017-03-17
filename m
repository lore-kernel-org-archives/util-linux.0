Return-Path: util-linux-owner@vger.kernel.org
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60731 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751049AbdCQLa4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 17 Mar 2017 07:30:56 -0400
Date: Fri, 17 Mar 2017 12:30:53 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
To: util-linux@vger.kernel.org, kernel@pengutronix.de
Subject: agetty reorders characters in login prompt
Message-ID: <20170317123053.37e73a6a@litschi.hi.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

agetty sometimes changes the order of the characters of the username in
the login prompt. For example, if I enter 'root' as username, the echo
reads 'orot' and the login fails, because the user does not exist.

A little bit background on the issue: I am running automated tests on
an embedded device with an i.MX6 processor which connects to the board
via serial console with 115200 baud. The test waits for the login
prompt and then sends the username via the serial console. In about
20 % of the test runs the echoed username slightly differs from the
sent username and the test fails.

I can also reproduce the issue when connecting to the serial console
via screen and pasting the username into the prompt. If I enter the
username manually or connect strace to agetty, the username is always
correct. I reproduced the problem on multiple different device
(although all with the same SoC).

I tested it with util-linux 2.29 with Linux 4.11-rc2 and 4.4.52.

I was able to trace the issue to the wait_for_term_input() function.
This function reads the first (few) bytes from the input queue and
after reading reinserts the bytes with the TIOCSTI ioctl back into the
queue. If new bytes are inserted into the input queue before the
TIOCSTI happens, the input queue will contain the bytes in the wrong
order and later reads on the input queue will not yield the original
input.

I also opened a bug in the kernel Bugzilla [1], because I am not sure
about the correct way to report bugs in util-linux.

Michael

[1] https://bugzilla.kernel.org/show_bug.cgi?id=194905
