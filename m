Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbaKLOam (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Nov 2014 09:30:42 -0500
Date: Wed, 12 Nov 2014 15:30:38 +0100
From: Karel Zak <kzak@redhat.com>
To: Boris Egorov <egorov@linux.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Coverity Scan analysis report
Message-ID: <20141112143038.GC5530@x2.net.home>
References: <5462F558.5000602@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5462F558.5000602@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 12, 2014 at 11:51:20AM +0600, Boris Egorov wrote:
> It is possible to analyze project using Coverity Scan. I've created a
> project on their website with my clone of util-linux on Github. You can see
> it here: https://scan.coverity.com/projects/3469?tab=overview (I can export
> report if you can't see it).
> So, it can be done for the main util-linux Github repo. Coupled with Travis
> CI it can generate regular analysis reports.

 Cool, it would be nice to have the reports for our community, but
 please, think twice before you fix anything, it generates many many
 nonsenses.

 I use Coverity for util-linux (usually for -rc releases) internally
 in Red Hat. Unfortunately it's impossible to share these reports publicly.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
