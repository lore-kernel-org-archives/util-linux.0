Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46720 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755641Ab1ILM0B (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Sep 2011 08:26:01 -0400
Date: Mon, 12 Sep 2011 14:25:56 +0200
From: Karel Zak <kzak@redhat.com>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: util-linux@vger.kernel.org
Subject: Re: [util-linux] agetty 2.20 --noclear
Message-ID: <20110912122556.GE16902@nb.net.home>
References: <x662lbqvn1@gzp> <20110902104318.GA28133@boole.suse.de> <20110902131508.GB4117@nb.redhat.com> <x6y5y63ize@gzp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x6y5y63ize@gzp>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 02, 2011 at 08:19:17PM +0200, Gabor Z. Papp wrote:
> * Karel Zak <kzak@redhat.com>:
> 
> | > That was backported due several bug reports from our own supporters
> | > as it seems to be a problem for many newbies.  Btw: AFAIK also kdm/gdm
> | > do such reports, don't they?
> 
> |  Maybe we can add --nohints for people who prefect more acetic
> |  interface....
> 
> That would be great, thanks.

 Implemented and pushed to github.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
