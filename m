Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752760AbeAQMjb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jan 2018 07:39:31 -0500
Date: Wed, 17 Jan 2018 13:39:27 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] hwclock: rename --debug option to --verbose
Message-ID: <20180117123927.clx3dnapz3rjgsxd@ws.net.home>
References: <27af199a-8ec2-634f-6e99-dd4047f9d5f4@gmx.com>
 <25e935d3-37ff-a02b-8e5e-30f41dd88ae0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25e935d3-37ff-a02b-8e5e-30f41dd88ae0@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 24, 2017 at 03:37:36PM -0500, J William Piggott wrote:
> 
> Warn on --debug; do not fallthrough because
> the message is lost in the verbose output.

Merged. 

It's change in options :-) but in this case the original option prints
a warning (and nowhere is guaranty of number and format of the debug
messages) and another functionality is not affected. So, I'm fine with
this change.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
