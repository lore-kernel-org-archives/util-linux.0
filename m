Return-Path: util-linux-owner@vger.kernel.org
Received: from odpn1.odpn.net ([212.40.96.53]:35124 "EHLO odpn1.odpn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925Ab1ICKAD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 3 Sep 2011 06:00:03 -0400
From: "Gabor Z. Papp" <gzp@papp.hu>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: dmesg(1) bug
References: <20110831104859.GB1547@nb.net.home> <x6zkiopqua@gzp>
	<20110902130931.GA4117@nb.redhat.com>
Date: Sat, 03 Sep 2011 12:00:00 +0200
Message-ID: <x6wrdq7xpb@gzp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Karel Zak <kzak@redhat.com>:

| > -generic-usb 0003:045E:001E.0001: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1/input0
| > +input: Microsoft Microsoft IntelliMouse\xffffffc2\xffffffae Explorer as /devices/pci0000:00/0000:00:1d.0/usb1/1-1/1-1:1.0/input/input1

| Do you have enabled widechar support? (See HAVE_WIDECHAR in
| config.h).

Yes, I have!
