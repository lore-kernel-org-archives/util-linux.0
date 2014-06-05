Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41660 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbaFEHsN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Jun 2014 03:48:13 -0400
Date: Thu, 5 Jun 2014 09:48:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: tests: hwclock questions
Message-ID: <20140605074805.GV9000@x2.net.home>
References: <201406050032.24233.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406050032.24233.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 05, 2014 at 12:32:24AM +0200, Ruediger Meier wrote:
> But before doing this I have two questions.

 Maybe we can remove the test at all (or use --force to enable the test). It 
 was always very problematic test and I have doubts it's still necessary as 
 relevant hwclock code is completely different and more robust now.

> 1. I wonder what is the original purpose of this test. Are we really 
> testing hwclock or the kernel or hardware? I mean setting and reading

 The purpose is to test how precisely is able hwclock to set HW time.
 Long time ago we had problem that each iteration added extra 0.5s to
 the time.

> cock 10 times ... could this really discover a bug in our hwclock code?

 Yes.

> 2. Why do we _set_ the time from ntp server at the beginning? Wouldnt it 
> be enough to check whether the offset to ntp is the same before and 
> after the test?

 Probably yes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
