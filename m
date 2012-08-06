Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41205 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab2HFTkH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 15:40:07 -0400
Received: by wgbdr13 with SMTP id dr13so3117129wgb.1
        for <util-linux@vger.kernel.org>; Mon, 06 Aug 2012 12:40:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Mon, 6 Aug 2012 21:40:05 +0200
Message-ID: <CAG27Bk3WxEuHi7pNUPjsXHL+e3-GceyTQrpU8tP80=EjMv-g_w@mail.gmail.com>
Subject: lscpu, MHz and ondemand governor
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Lets take multiprocessor computer and cpu intensive program, for
example the following.

void main(void)
{
        while (1) ;
}

I can see lscpu reporting high and low MHz value, which is normal on
system is instructed to use ondemand governor.  But I can easily think
someone being confused by that behaviour, especially if a person is
using lscpu output as source of inventory (and numbers keep on
changing).  So should the governor in use, MHz range, and which MHz
values are in use be reported by lscpu?

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
