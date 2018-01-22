Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbeAVKQG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 22 Jan 2018 05:16:06 -0500
Date: Mon, 22 Jan 2018 11:16:02 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] hwclock: add --ul-debug implementing debug.h
Message-ID: <20180122101602.u6vo3teot3dnqmk7@ws.net.home>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
 <c0ee83b1-2736-313d-802b-4937c6f71d85@gmx.com>
 <20171229113824.72y6cgyqta42mt2y@ws.net.home>
 <3b97fbb3-d191-1aa1-2d6e-ee8e17174cea@gmx.com>
 <20180108105527.kj62amdwlgoj3f7l@ws.net.home>
 <40a664bf-1db7-5f26-ab6f-2c061ee40dbe@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40a664bf-1db7-5f26-ab6f-2c061ee40dbe@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 21, 2018 at 02:38:25PM -0500, J William Piggott wrote:
> I wonder how a debug.h patch would be received on the libc-alpha list?

Do you see any alpha specific issue there? 

> Anyway, I don't want to cause problems about this. You've made a compromise for
> hwclock and I appreciate that. My comments are only food-for-thought, or as you
> say brainstorming. I just think the general concept is not so good.

Well, it was designed for libs and later used (with no change) for
another code like lsblk or script... 

Anyway, merged to hwclock with --ul-debug.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
