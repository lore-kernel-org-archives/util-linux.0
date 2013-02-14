Return-Path: util-linux-owner@vger.kernel.org
Received: from kawka.in.waw.pl ([178.63.212.103]:56835 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876Ab3BNB5n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 20:57:43 -0500
Received: from zbyszek by kawka.in.waw.pl with local (Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1U5o50-0003jk-9K
	for util-linux@vger.kernel.org; Thu, 14 Feb 2013 02:57:42 +0100
Date: Thu, 14 Feb 2013 02:57:42 +0100
From: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: util-linux@vger.kernel.org
Subject: build problem: MNT_ERR_AMBIFS
Message-ID: <20130214015742.GR4278@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

../libmount/src/context.c: In function 'mnt_context_guess_fstype':
../libmount/src/context.c:1525:10: error: 'MNT_ERR_AMBIFS' undeclared (first use in this function)

../sys-utils/mount.c: In function ‘mk_exit_code’:
../sys-utils/mount.c:388:9: error: ‘MNT_ERR_AMBIFS’ undeclared (first use in this function)

Incomplete git commit?

Zbyszek
