Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.95]:27269 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932134Ab2L1Tfs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Dec 2012 14:35:48 -0500
Message-ID: <50DDF41D.9030805@zoho.com>
Date: Fri, 28 Dec 2012 20:33:49 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: util-linux@vger.kernel.org, kerolasa@gmail.com, grawity@gmail.com,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH v2] sys-tools: Enhance unshare command to support the
 switching of namespaces
References: <1355944006-27234-1-git-send-email-nhorman@tuxdriver.com> <1356027729-26098-1-git-send-email-nhorman@tuxdriver.com> <50DD9695.4080507@zoho.com> <20121228161217.GA5325@neilslaptop.think-freely.org>
In-Reply-To: <20121228161217.GA5325@neilslaptop.think-freely.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>> There are also pid and user namespaces there, but support for those are
>> better handled in a different patch IMHO.
>>
> I'm not really sure what you mean by a different patch here.  Why would I add
> support for setns for other pid/uts namespaces in a different patch?

Because unshare doesn't currently support launching processes in a new
pid or user namespace. :)



