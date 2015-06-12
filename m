Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.eu.citrix.com ([185.25.65.24]:52043 "EHLO
	SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932516AbbFLJoQ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 12 Jun 2015 05:44:16 -0400
From: Felipe Franciosi <felipe.franciosi@citrix.com>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: losetup race on -f file
Date: Fri, 12 Jun 2015 09:44:03 +0000
Message-ID: <9F2C4E7DFB7839489C89757A66C5AD62BA1A0C@AMSPEX01CL03.citrite.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi All,

I'm seeing a race when using "losetup -f file". Some research pointed me to a 2007 path that introduced a "retry" mechanism if the module returned EBUSY. At some point before the project went into git.kernel.org this commit went away.

Can anyone clarify? I'm currently flock()ing /var/lock/losetup outside calls to losetup.
Objections to a losetup patch to do that internally?

Easy repro: for i in {1..100}; do losetup -f image & done
Then check out the output of "losetup -a"

Thanks,
Felipe