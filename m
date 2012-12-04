Return-Path: util-linux-owner@vger.kernel.org
Received: from cn.fujitsu.com ([222.73.24.84]:6280 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750968Ab2LDGkA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 4 Dec 2012 01:40:00 -0500
Message-ID: <50BD9AD6.60109@cn.fujitsu.com>
Date: Tue, 04 Dec 2012 14:40:22 +0800
From: Miao Xie <miaox@cn.fujitsu.com>
Reply-To: miaox@cn.fujitsu.com
MIME-Version: 1.0
To: xiyou.wangcong@gmail.com, kzak@redhat.com, sandeen@redhat.com,
        mcepl@redhat.com
CC: util-linux@vger.kernel.org
Subject: [QUESTION] why not break the EOF limit of fallocate
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi, everyone.

I have a question about the punch hole function of fallocate. According to
the manual of fallocate command, the hole that we want to punch should not
exceed the end of the file, so my question is why do we forbid fallocate
punching a hole that past EOF?

As we know, we can pre-allocate some space past EOF by fallocate command.
I think punch-hole of fallocate is the most natural approach to reclaim
that space. Though the manual says truncate command can do the same thing,
it is a bit complex, especially we just want to reclaim the front end of
that space.

I find the code of fallocate command doesn't has this limit(fallocate code
doesn't check the range of hole), so I hope we can remove the limit in the
manual if it is possible.

Thanks
Miao
