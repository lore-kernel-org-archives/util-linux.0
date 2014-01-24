Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f45.google.com ([74.125.83.45]:50900 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbaAXKML (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Jan 2014 05:12:11 -0500
Received: by mail-ee0-f45.google.com with SMTP id b15so862082eek.4
        for <util-linux@vger.kernel.org>; Fri, 24 Jan 2014 02:12:10 -0800 (PST)
Received: from [10.0.0.1] (bzq-79-177-15-211.red.bezeqint.net. [79.177.15.211])
        by mx.google.com with ESMTPSA id g1sm1758482eet.6.2014.01.24.02.12.08
        for <util-linux@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 02:12:09 -0800 (PST)
Message-ID: <1390558252.22222.14.camel@debox>
Subject: mount, vfat and fmask
From: ST <smntov@gmail.com>
To: util-linux@vger.kernel.org
Date: Fri, 24 Jan 2014 12:10:52 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I have to deal with users who use vfat on their usb sticks. I mount them
with certain fmask and all files get certain permissions. Once the media
is mounted I have to go through all files and change the permission of
some files if they fulfill certain conditions. chmod doesn't work in
this case.

1. Do you have any ideas for a workaround?
2. Is it possible to achieve this somehow with sudo?
3. Is there a program that creates some kind of virtual layer and
emulates extX filesystem above vfat?
4. If there is no other way but to change the source code of mount(or
something else?) what are the places in the code I have to take look on?

Thank you very much in advance
Sim


ps: I could find how I can subscribe to the list, but I never saw the
email address of the list written explicitly. Is it left as exercise to
the subscriber to guess the address? Or is it a kind of IQ test to
filter out those who is not eligible to use the list? :)  

