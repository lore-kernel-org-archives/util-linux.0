Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:49912 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206Ab3ATX5b (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Jan 2013 18:57:31 -0500
Date: Mon, 21 Jan 2013 00:36:22 +0100
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: is one allowed to reenter a user namespace?
Message-ID: <20130120233621.GI17370@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
when trying to enter a namespace, the behaviour wrt. to entering an
existing namespace that the process is _already_ a part of is
different for user names and all other namespaces. For user namespaces
one gets EINVAL, while for other namespaces it succeeds. In other
words, for user namespaces only, entering the namspace is not idempotent.

# unshare --mount sleep 10000 &

# nsenter --target=$(pgrep sleep) --mount /bin/true
# nsenter --target=$(pgrep sleep) --ipc /bin/true
# nsenter --target=$(pgrep sleep) --net /bin/true
# nsenter --target=$(pgrep sleep) --uts /bin/true
# nsenter --target=$(pgrep sleep) --user /bin/true
nsenter: setns of 'ns/user' failed: Invalid argument
(and the EINVAL is from setns())

Is this difference intended?

-
Zbyszek
