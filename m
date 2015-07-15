Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbbGOMbZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jul 2015 08:31:25 -0400
Date: Wed, 15 Jul 2015 14:31:24 +0200
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?0JDQvdC00YDQtdC5INCT0LDQstGA0LjQu9C40L0=?=
	<gaal.dev@gmail.com>
Cc: majordomo@vger.kernel.org, util-linux@vger.kernel.org
Subject: Re: fdisk - mistyping in gpt type table (one character)
Message-ID: <20150715123124.GA31997@ws.net.home>
References: <CAK13fG4CfFQCWLidruBfZ786ri9B_ov8C60q7it9NfgURvuc=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAK13fG4CfFQCWLidruBfZ786ri9B_ov8C60q7it9NfgURvuc=w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 13, 2015 at 10:59:24AM +0300, Андрей Гаврилин wrote:
>         DEF_GUID("0394Ef8B-237C-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD UFS")),
>
> One string has to be replaced.
> 
>         DEF_GUID("0394EF8B-237E-11E1-B4B3-E89A8F7FC3A7", N_("MidnightBSD UFS")),

 Fixed, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
