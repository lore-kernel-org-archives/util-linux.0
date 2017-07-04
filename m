Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.135]:62804 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdGDJA5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jul 2017 05:00:57 -0400
Subject: Re: [PATCH 3/5] hwclock: final usage() strings slice
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Karel Zak <kzak@redhat.com>,
        J William Piggott <elseifthen@gmx.com>,
        util-linux@vger.kernel.org
References: <9cf88d57-3a45-cd47-ac96-3495e09d81c5@gmx.com>
 <20170704075833.eqhwwhpo36s2i63d@ws.net.home>
 <192a27a9-6e22-5483-0222-23cd992af8d2@bernhard-voelker.de>
 <201707041055.05661.sweet_f_a@gmx.de>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <c26e8514-2f8b-92da-9638-0883d8b87ecb@bernhard-voelker.de>
Date: Tue, 4 Jul 2017 11:00:26 +0200
MIME-Version: 1.0
In-Reply-To: <201707041055.05661.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/04/2017 10:55 AM, Ruediger Meier wrote:
> Yes this is nice because easy to count that no usage output is longer 
> than 80 chars. But I guess there are too many different opinions about 
> these stylish things. I'd also like to have just one string and only 
> one printf command for all options (like mkfs.cramfs.c). But this may 
> cause more work for translators each time we add a new option. Don't 
> know if that would be a real problem.

In coreutils, we got the feedback from the translators that they'd prefer
one string per option.  Otherwise, changes are harder to track for them.

Have a nice day,
Berny

