Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752437AbbBJK3C (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 05:29:02 -0500
Date: Tue, 10 Feb 2015 11:28:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] Fix "Script started" buffering race
Message-ID: <20150210102858.GC19845@ws.net.home>
References: <54D50F02.4000709@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54D50F02.4000709@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 06, 2015 at 07:59:14PM +0100, Stanislav Brabec wrote:
> Before:
> Hallo World
> Script started, file is typescript
> Script started, file is typescript
> Script done, file is typescript
> 
> After:
> Script started, file is typescript
> Hallo World
> Script done, file is typescript

 Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
