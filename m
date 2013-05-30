Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47878 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967694Ab3E3Hdd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 30 May 2013 03:33:33 -0400
Date: Thu, 30 May 2013 09:33:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Linda Walsh <lkml@tlinx.org>
Cc: util-linux@vger.kernel.org
Subject: Re: RFD: patch: su: ignoring switches and continuing:
  --preserve-environment v. --login
Message-ID: <20130530073330.GG30341@x2.net.home>
References: <51A66104.3060508@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51A66104.3060508@tlinx.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 29, 2013 at 01:11:48PM -0700, Linda Walsh wrote:
> > @@ -98,6 +98,7 @@ Preserves the whole environment, ie does not set
> >  .B USER
> >  nor
> >  .BR LOGNAME .
> > +The option is ignored if the option \fB\-\-login\fR is specified.
> ---
> There are 2 problems
> On the surface, this patch, alone, appears to remove desirable
> functionality from su, and, it is a dangerous change in default

 Did you read the code?

 if (simulate_login) {
    ...
 } else {

    if (change_environment) {
    ....
    }

 }

 the patch does not change anything...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
