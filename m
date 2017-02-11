Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36945 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751075AbdBKU6i (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 11 Feb 2017 15:58:38 -0500
Message-Id: <1486846717.4143627.877978656.4E6859A9@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Date: Sat, 11 Feb 2017 21:58:37 +0100
Subject: Re: [PATCH 0/3] pull: blkreset and blkreport polishing
In-Reply-To: <20170211141052.26154-1-kerolasa@iki.fi>
References: <20170211141052.26154-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sat, Feb 11, 2017, at 15:10, Sami Kerola wrote:
> It is a pity there are now two new
> blkre* tools instead of single 'zblkadm (reset|report)'.  A single command
> would have less boilerplating going on, and would form logical path how to
> add new features in future.

The commands haven't been in a release yet, so there is still time
for you to propose a better solution and rework things into a single
command.

Benno

-- 
http://www.fastmail.com - Choose from over 50 domains or use your own

