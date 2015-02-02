Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53119 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983AbbBBJph (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 04:45:37 -0500
Date: Mon, 2 Feb 2015 10:45:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: deleting an extended partition with cfdisk leaves its contained
 partitions in existence
Message-ID: <20150202094533.GA16162@ws.net.home>
References: <1422653660.1205461.221145325.78FCAC9D@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422653660.1205461.221145325.78FCAC9D@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 30, 2015 at 10:34:20PM +0100, Benno Schulenberg wrote:
> Deleting an extended partition should either delete also all the
> partitions it contains, or it should refuse the deletion before all
> the contained partitions have been deleted.  Probably the first
> option is the most user-friendly.

 Fixed, now it deletes also logical partitions.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
