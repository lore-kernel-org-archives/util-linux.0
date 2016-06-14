Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12705 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750818AbcFNKjs (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2016 06:39:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5EAchkL084434
	for <util-linux@vger.kernel.org>; Tue, 14 Jun 2016 06:39:47 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23gctgkmrs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Tue, 14 Jun 2016 06:39:47 -0400
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Tue, 14 Jun 2016 11:39:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8D0E917D8069
	for <util-linux@vger.kernel.org>; Tue, 14 Jun 2016 11:38:36 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5EAbN2c2556216
	for <util-linux@vger.kernel.org>; Tue, 14 Jun 2016 10:37:23 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5EAbNMV014408
	for <util-linux@vger.kernel.org>; Tue, 14 Jun 2016 04:37:23 -0600
Date: Tue, 14 Jun 2016 12:37:21 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add drawer support
References: <1465888954-62716-1-git-send-email-heiko.carstens@de.ibm.com>
 <20160614084349.bmut3xx3aorkievj@ws.net.home>
 <20160614100835.GE3754@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160614100835.GE3754@osiris>
Message-Id: <20160614103721.GF3754@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 14, 2016 at 12:08:35PM +0200, Heiko Carstens wrote:
> On Tue, Jun 14, 2016 at 10:43:49AM +0200, Karel Zak wrote:
> > 
> >  Hi,
> > 
> > On Tue, Jun 14, 2016 at 09:22:33AM +0200, Heiko Carstens wrote:
> > > the recent IBM z13 machines added yet another cpu topology level which
> > > is called 'drawer'. I'd like to have support for this within lscpu as
> > > well. The kernel patch that makes the new sysfs interfaces available
> > > will be merged during the next merge window. Therefore the first
> > > kernel release that contains the required interfaces will be v4.8.
> > 
> > maybe you can use tests/ts/lscpu/mk-input.sh to create a dump from 
> > /proc and /sys. Then we can test this new feature independently on 
> > HW and kernel.
> 
> I had a test case but threw it away, since the "lscpu -p" output does not
> contain the new drawer column.
> 
> However I will send a patch which replaces one of the existing s390
> testcases, so we get at least a bit of coverage for the summary output.

Ok, I'll send an additional testcase since the existing s390 ones contain
quite a lot of variations which I'd like to keep. Patch will arrive soon ;)

