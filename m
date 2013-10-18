Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52663 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753152Ab3JRMc4 convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Oct 2013 08:32:56 -0400
Message-Id: <1382099575.30040.35570461.3189D1B8@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: =?UTF-8?Q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?=
	<vnwildman@gmail.com>
Cc: "util-linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <525F2FC0.70802@gmail.com>
References: <525F2FC0.70802@gmail.com>
Subject: Re: gettext question
Date: Fri, 18 Oct 2013 14:32:55 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Oct 17, 2013, at 2:30, Trần Ngọc Quân wrote:
> I have a question:
> I will sent rc2 translation, so do I have to sent util-linux-2.24-rc1.vi.po?

It is never needed to upload a PO file for an older version.  Even stronger:
upstream will ever only see your PO file if you upload one for the latest
shown version.

Those older versions of PO files are only kept around for history sake, and
for when you know that a distribution uses a specific version and you want
to make it easy for them to update the translation.  But I don't know of any
distribution that actually does this.

Benno

-- 
http://www.fastmail.fm - Access your email from home and the web

