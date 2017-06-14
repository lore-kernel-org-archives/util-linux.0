Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9331 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbdFNKEj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Jun 2017 06:04:39 -0400
Date: Wed, 14 Jun 2017 12:04:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Fix even more random compiler warnings
Message-ID: <20170614100435.xiyaup2zjyd3wn2c@ws.net.home>
References: <20170613153235.11164-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170613153235.11164-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 13, 2017 at 05:32:30PM +0200, Ruediger Meier wrote:
> Ruediger Meier (5):
>   libfdisk: cleanup sun label checksum usuage
>   libfdisk: fix guid usage of packed structure gpt_entry
>   libsmartcols: fix warning "unused parameter"
>   wall: fix OSX getgrouplist, gid_t* vs int*
>   tests: add more tests for line(1)

Applied from github, except wall patch -- I've used another solution.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
