Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:23000 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbbCBRyJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Mar 2015 12:54:09 -0500
Message-ID: <54F4A3BE.1090708@draigBrady.com>
Date: Mon, 02 Mar 2015 17:54:06 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Fedora Cloud SIG <cloud@lists.fedoraproject.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: cloud-init issues with new sfdisk
References: <20150302053056.GB19220@media.redhat.com>
In-Reply-To: <20150302053056.GB19220@media.redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/03/15 05:30, Dusty Mabe wrote:
> 
> The "new" sfdisk that was rewritten (see [1]) doesn't support an option that 
> is used by growpart (which is used by cloud-init). Below is the error that occurs
> in the TC7 compose at [2]:
> 
> [root@t7 ~]# growpart --dry-run /dev/vda 1                                                                                                                                                                    
> failed [sfd_geom:1] sfdisk /dev/vda --show-pt-geometry
> sfdisk: unrecognized option '--show-pt-geometry'
> 
> Does anyone know of an existing bug report for this? If not I'll write one up.
> 
> Dusty
> 
> [1] - https://github.com/karelzak/util-linux/commit/1881390de25df8587b8fc281c451796f7d032dd3#diff-31d5cc325380dbdafe64d0e019846f12R20
> [2] - http://koji.fedoraproject.org/koji/taskinfo?taskID=9097429

You're right that that option was removed with:
http://git.kernel.org/cgit/utils/util-linux/util-linux.git/commit/?id=v2.25-251-g1881390

Now it's a very little used option, and according to the following,
growpart seems to be the only user.:
http://codesearch.debian.net/results/show-pt-geometry/page_1

Karel is there an alternative that growpart could use?

thanks,
Pádraig.
