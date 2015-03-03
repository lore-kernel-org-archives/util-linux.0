Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbbCCAV0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Mar 2015 19:21:26 -0500
Date: Tue, 3 Mar 2015 01:21:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: sfdisk problem with a partition starting early on a GPT disk
Message-ID: <20150303002122.GN8046@ws.net.home>
References: <20150301155610.GW3933@cordes.ca>
 <20150302100652.GI8046@ws.net.home>
 <20150302161932.GX3933@cordes.ca>
 <20150302201311.GM8046@ws.net.home>
 <20150302223110.GB3933@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150302223110.GB3933@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 02, 2015 at 06:31:10PM -0400, Peter Cordes wrote:
>  Ok, cool.  It might not be hard to detect scripted partitions
> starting below 2048, but above 33, and set first-lba to the lowest
> number found.  Or to 34, if a partition before 2048 is found at all.

 Yes, I thought about... maybe I'll implement it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
