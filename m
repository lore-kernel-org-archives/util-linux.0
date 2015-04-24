Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36726 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbDXE0C (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Apr 2015 00:26:02 -0400
Received: by pdea3 with SMTP id a3so37555412pde.3
        for <util-linux@vger.kernel.org>; Thu, 23 Apr 2015 21:26:01 -0700 (PDT)
Date: Thu, 23 Apr 2015 21:26:04 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/1] hwclock: Remove TZUTC
Message-ID: <20150424042603.GB1841@newbook>
References: <1429764592-15947-1-git-send-email-ibid.ag@gmail.com>
 <55398435.4090504@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55398435.4090504@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 23, 2015 at 07:45:57PM -0400, J William Piggott wrote:
> 
> The patch that introduced TZUTC should have been rejected.
> Mr. Parmelee misunderstood how to use and configure the
> zoneinfo 'right' database. This was likely due to the 'right'
> database being undocumented. I added information about the
> database to the hwclock(8) man-page, and intended to remove
> the TZUTC environment variable from hwclock when refactoring.
> Since this regression needs to be addressed, it might as well
> be removed now.

> TZUTC is undocumented and should be safe to remove.
> 

Thanks.
This seems like the better fix.

Thank you,
Isaac Dunham
