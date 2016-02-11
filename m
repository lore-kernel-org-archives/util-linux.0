Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbcBKJny (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 04:43:54 -0500
Date: Thu, 11 Feb 2016 10:43:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
Message-ID: <20160211094352.6ncnnirhyd4jjd34@ws.net.home>
References: <56B0EEB2.1060707@suse.cz>
 <56B10E38.7040407@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B10E38.7040407@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 02, 2016 at 09:14:48PM +0100, Stanislav Brabec wrote:
> Stanislav Brabec wrote:
> >Coverage:
> 
> I just found a bug in my testcase:
> To prevent race bind-mnt has to be created in time of fs creation.
> 
>  btrfs subvol create s3 >/dev/null
> +mkdir -p s3/bind-mnt

So, this is enough to fix the testcase, right? I'd like to merge it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
