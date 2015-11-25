Return-Path: util-linux-owner@vger.kernel.org
Received: from e37.co.us.ibm.com ([32.97.110.158]:34146 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbKYUJt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Nov 2015 15:09:49 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <sukadev@linux.vnet.ibm.com>;
	Wed, 25 Nov 2015 13:09:49 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 60E8F19D8048
	for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 12:57:54 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tAPK9l2O20644066
	for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 13:09:47 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tAPK9ldB018702
	for <util-linux@vger.kernel.org>; Wed, 25 Nov 2015 13:09:47 -0700
Date: Wed, 25 Nov 2015 12:09:45 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: nacc@linux.vnet.ibm.com, util-linux@vger.kernel.org
Subject: Re: [RFC][PATCH 1/1] lscpu: Print physical cpu information
Message-ID: <20151125200945.GA16551@us.ibm.com>
References: <1448402285-15621-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20151125091715.GE4955@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151125091715.GE4955@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak [kzak@redhat.com] wrote:
| On Tue, Nov 24, 2015 at 01:58:05PM -0800, Sukadev Bhattiprolu wrote:
| > Appreciate comments on the proposal including following:
| > 
| > 	- Should we instead display the physical information unconditionally?
| 
| yes

Ok. I have made it unconditional now.

| 
| > 	  Maybe add '--system' or '--no-physical' to suppress the physical
| > 	  topology info?
| > 
| > 	- Should we ignore (as this patch does) or fail if '--physical'
| > 	  is specified on yet unsupported architectures?
| 
| I have originally thought that --physical will overwrite the current
| output (e.g. "Sockets:"). If we add information from librtas as
| additional fields (e.g. "Physical sockets:") than maybe we don't need
| the option --physical at all, and all we need is to describe all
| (difference between system/physical) in docs.

Ok. I have updated the man page.

| 
| > +static void read_physical_info_powerpc(struct lscpu_desc *desc)
| > +{
| > +	char buf[4096];
| 
|   buf[BUFSIZ]

Yes,

| 
| ...
| 
| >  static void
| >  read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
| >  {
| > @@ -506,6 +555,9 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
| >  		desc->dispatching = path_read_s32(_PATH_SYS_CPU "/dispatching");
| >  	else
| >  		desc->dispatching = -1;
| >
| 
| you should not read information from rtas when lscpu is running in
| shapshot mode ("snapshot" means that we read info from /sys and /proc
| dump rather than from a real system; we use it for regression tests).
| 
|    if (mod->system == SYSTEM_ALIVE)
|         read_physical_info_powerpc(desc);

OK.

| 
| and mod->physical will be  probably unnecessary if the physical information
| will be printed unconditionally ;-)
| 
| > +	if (mod->physical)
| > +		read_physical_info_powerpc(desc);
| >  }

Sukadev

