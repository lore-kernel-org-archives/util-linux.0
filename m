Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout06.t-online.de ([194.25.134.19]:47525 "EHLO
	mailout06.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977Ab3J3QNq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 12:13:46 -0400
Date: 30 Oct 2013 17:13:00 +0100
From: Hullen@t-online.de (Helmut Hullen)
To: util-linux@vger.kernel.org
Message-ID: <Cgqs0l0eCXB@helmut.hullen.de>
In-Reply-To: <527122AF.90003@ubuntu.com>
Subject: Re: Bind mounts record fstype of none
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: helmut@hullen.de
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hallo, Phillip,

Du meintest am 30.10.13:

> I came across an old bug filed in debian noting that mount records
> the fstype for bind mounts as 'none' and this causes df to suppress
> showing it.  This seems like an error to me.  The type should be what
> the actual filesystem type is, and if df wants to suppress showing
> bind mounts, it should do so based on the bind flag.

For seeing "bind" I'd prefer

        mount

or

        mount | grep -w bind

Viele Gruesse!
Helmut
