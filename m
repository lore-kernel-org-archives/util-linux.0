Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751491AbdFZMMZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 08:12:25 -0400
Date: Mon, 26 Jun 2017 14:12:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Daniil Zhilin <just4steam778@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty doesn't handle the second backspace properly during login
Message-ID: <20170626121221.wxkccti4del3buvf@ws.net.home>
References: <20170623013812.5cf11bec@HomePC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170623013812.5cf11bec@HomePC.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 23, 2017 at 01:38:12AM +0300, Daniil Zhilin wrote:
> Hello. When using the Colemak keyboard layout that assigns a second
> backspace to Caps Lock, during TTY login this mapping generates '^H'
> instead.
> 
> util-linux version 2.29.2-2 on Arch Linux.

All this should be fixed in the next v2.30.1.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
