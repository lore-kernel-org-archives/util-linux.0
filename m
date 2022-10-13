Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E704EC433FE
	for <util-linux@archiver.kernel.org>; Thu, 13 Oct 2022 20:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJMUnK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMUnI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 13 Oct 2022 16:43:08 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB24169CDB
        for <util-linux@vger.kernel.org>; Thu, 13 Oct 2022 13:43:07 -0700 (PDT)
Received: from [192.168.101.10] ([91.12.163.236]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEF87-1otE3v0Jin-00AB49; Thu, 13 Oct 2022 22:43:02 +0200
Content-Type: multipart/mixed; boundary="------------bQ2vNlIm7ILeO1tyTk8e32YV"
Message-ID: <08dd1386-3511-2f1a-b041-0a445d34ae1a@bernhard-voelker.de>
Date:   Thu, 13 Oct 2022 22:43:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Proposal for new column(1) flag
To:     Thomas Voss <mail@thomasvoss.com>, util-linux@vger.kernel.org
References: <CNL1J5PPBA9T.2ZR8EL0OSX1XJ@mango-os>
Content-Language: en-US
From:   Bernhard Voelker <mail@bernhard-voelker.de>
In-Reply-To: <CNL1J5PPBA9T.2ZR8EL0OSX1XJ@mango-os>
X-Provags-ID: V03:K1:S7BgC6iDMqtTajQsvfZDMqijmhgpLTgn7lFda/K5jHI5OdPxh73
 njxpUwTba/NmS40MKho+2PKShtn9s21MNMNbHikiYGR5ApkXuiN0ecOFmAIq+Mj0ahrDKxm
 j4djl6mGRYyVhsVfMwbq3c81FTAuAbX/aUQzBtPQaRqvbYPoEdnsOnZfYIjuhjnhC1hf+9E
 g9ZZAYER+EvwxnnEjKeRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:85EfRqSP0p4=:pks3ATpfK4P8qgpdpdDe6M
 2eYmuNo6kSU3EEpLIa1BIwimSBh1UVGxheAvEP7uGv+C6uUdYgcFLdE0fPMiHEYVPPlpFDqW/
 cQWHxyYE25d1NAmfGUN8YfJrDxRZG1ELKLs4StLcCS3TrzRURt+T4bZfHDqd3aGMMQCoDAniw
 VUrO2bX4BQGRsqqteSjvKFmTmkDOsj4m/emQDmdMFQsGvnnvTPJkVPSiNrqXB4qVc70jDQGfG
 F5hVasGJkBfNi+hb1aTPC07jyXH4FXgXPwvJROkX9RM6X8l3D1Jr8BYZbIBfoy9LNJ1Hx+f+0
 S73ANd0Sf4yNcBGMlnEPKyBSxFp8P9u3LjbHQqhhus4PbbltDoLFvF8G/dmEdQcdVjmZRoYz4
 RGMCg2dxeKob92PMUtR8QPnzyBOXhvi2fR+qvmk+pqGfx6Djys+ddRPY8361DzzmzpY/+OSJJ
 uPE1apeaAgK/kp6Ov6ehwY0KlF3U8Jzd8gJr0/UMBS/TbXcC0QdQmgj5/7zKtFKyKTww0lKZ3
 ZR+DdsJkh1ie16fFUyof/AzcO5HRCphP/iu24K3vrzOEijTHciU3qkfwPloYRu/KSt6jIMGmj
 CaSCwbCrOZc1V0N0ltBTn8tvuukIqgHWiJKZ2hoLtZHKvGWoN7FIp5UP9/QKh8pNpN7Hce/JG
 HHVTGxTW+TzYXu/RGskpNIwb+v8acmoSq5mK4flPbvQY3v1qwQMrcnUPNi90PDtbEtK1PTjiu
 PlM5lWz147zSWk/ydCEK5SOh2bff0gQB1DneHQZwgTPMeodV7kM91NL4oh4ojG3NDRbvWjGEt
 2YUAxbjyK56UAPnCHykP8FQH5D+bg==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is a multi-part message in MIME format.
--------------bQ2vNlIm7ILeO1tyTk8e32YV
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/22 21:26, Thomas Voss wrote:
> Hello there,
> 
> I'm not sure if this is exactly the right place to ask, so forgive me if
> it isn't but I was thinking of a potential new flag for the column(1)
> utility and would like to get some feedback on whether or not it would
> even be accepted before I try to submit a patch.
> 
> The basic issue I am aiming to fix is this:  When you have a bunch of
> lines and you want to display them in a more "human friendly" manner, you
> may decide to display them using columns.  This is what ls does as the
> default behavior when listing files and we can in theory do this by
> piping the output of whatever command we run into column.  The issue I
> found however is that the way column operates is by splitting each row
> into multiple columns where every column has the same width (a width
> which can hold the longest input line).  ls on the other hand tries to
> make each column as thin as possible, with a gap of two spaces between
> each column.  This means that in many cases ls can fit the same data into
> more columns than center can.
> 
> Now when listing files this is not a problem, you can always use ls
> instead of center.  But I recently found myself wanting to do this with a
> list of movies that I had stored in a file, and so being able to just the
> following would be much more convenient, but the gaps between the columns
> is just too large:
> 
> 	$ column movie-list
> 
> So my proposal is to add a new flag, perhaps -g (g for gap) which allows
> you to specify how wide you want the gaps between the columns to be in
> spaces, and then to columnate that way.  That change would make these two
> lines identical:
> 
> 	$ ls *
> 	$ ls * | column -g 2
> 
> - Thomas

Hmm, you missed to give actual examples.  Is it like the output of this?

   $ ls * | column -xc $COLUMNS | column -t

(Example output in attached file to avoid line wrapping in the email.)

Have a nice day,
Berny
--------------bQ2vNlIm7ILeO1tyTk8e32YV
Content-Type: text/plain; charset=UTF-8; name="out"
Content-Disposition: attachment; filename="out"
Content-Transfer-Encoding: base64

QSQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEFBJCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBQUJDREVGSElK
S0xNTk9QYTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUFCQ0RFRkhJSktMTU5P
UGEyCkFBQkNERUZISUpLTE1OT1BiMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBBQUJDREVGSElKS0xNTk9QYjIgICAgICAgICAgICAgICAgICAgICAgQUFCQ0RF
RkhJSktMTU5PUHF3ZXJ0eXVpb3Bhc2RmZ2hqa2x6eGN2Ym5tICAgICAgIEFBQkNERUZISUpL
TE1OT1B6MTIzNApBQUJDREVGYTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQUFCQ0RFRmEyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEFBQkNERUZiMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBQUJD
REVGYjIKQUFCQ0RFRnF3ZXJ0eXVpb3Bhc2RmZ2hqa2x6eGN2Ym5tICAgICAgICAgICAgICAg
ICAgICAgICAgIEFBQkNERUZ6MTIzNCAgICAgICAgICAgICAgICAgICAgICAgICAgICBBQkNE
RUZBJCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUJDREVGQUJD
REVGSElKS0xNTk9QYTEKQUJDREVGQUJDREVGSElKS0xNTk9QYTIgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEFCQ0RFRkFCQ0RFRkhJSktMTU5PUGIxICAgICAgICAgICAg
ICAgICBBQkNERUZBQkNERUZISUpLTE1OT1BiMiAgICAgICAgICAgICAgICAgICAgICAgICAg
QUJDREVGQUJDREVGSElKS0xNTk9QcXdlcnR5dWlvcGFzZGZnaGprbHp4Y3Zibm0KQUJDREVG
QUJDREVGSElKS0xNTk9QejEyMzQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFC
Q0RFRkFCQ0RFRmExICAgICAgICAgICAgICAgICAgICAgICAgICBBQkNERUZBQkNERUZhMiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUJDREVGQUJDREVGYjEKQUJDREVG
QUJDREVGYjIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFC
Q0RFRkFCQ0RFRnF3ZXJ0eXVpb3Bhc2RmZ2hqa2x6eGN2Ym5tICBBQkNERUZBQkNERUZ6MTIz
NCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQUJDREVGSElKS0xNTk9QQSQKQUJD
REVGSElKS0xNTk9QQUJDREVGSElKS0xNTk9QYTEgICAgICAgICAgICAgICAgICAgICAgICAg
IEFCQ0RFRkhJSktMTU5PUEFCQ0RFRkhJSktMTU5PUGEyICAgICAgICBBQkNERUZISUpLTE1O
T1BBQkNERUZISUpLTE1OT1BiMSAgICAgICAgICAgICAgICAgQUJDREVGSElKS0xNTk9QQUJD
REVGSElKS0xNTk9QYjIKQUJDREVGSElKS0xNTk9QQUJDREVGSElKS0xNTk9QcXdlcnR5dWlv
cGFzZGZnaGprbHp4Y3Zibm0gIEFCQ0RFRkhJSktMTU5PUEFCQ0RFRkhJSktMTU5PUHoxMjM0
ICAgICBBQkNERUZISUpLTE1OT1BBQkNERUZhMSAgICAgICAgICAgICAgICAgICAgICAgICAg
QUJDREVGSElKS0xNTk9QQUJDREVGYTIKQUJDREVGSElKS0xNTk9QQUJDREVGYjEgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFCQ0RFRkhJSktMTU5PUEFCQ0RFRmIyICAg
ICAgICAgICAgICAgICBBQkNERUZISUpLTE1OT1BBQkNERUZxd2VydHl1aW9wYXNkZmdoamts
enhjdmJubSAgQUJDREVGSElKS0xNTk9QQUJDREVGejEyMzQKQUJDREVGSElKS0xNTk9QYTEg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFCQ0RFRkhJSktMTU5P
UGEyICAgICAgICAgICAgICAgICAgICAgICBBQkNERUZISUpLTE1OT1BiMSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQUJDREVGSElKS0xNTk9QYjIKQUJDREVGSElKS0xNTk9Q
cXdlcnR5dWlvcGFzZGZnaGprbHp4Y3Zibm0gICAgICAgICAgICAgICAgIEFCQ0RFRkhJSktM
TU5PUHoxMjM0ICAgICAgICAgICAgICAgICAgICBBQkNERUZhMSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQUJDREVGYTIKQUJDREVGYjEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFCQ0RFRmIyICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBQkNERUZxd2VydHl1aW9wYXNkZmdoamtsenhjdmJu
bSAgICAgICAgICAgICAgICAgQUJDREVGejEyMzQKQWExICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFhMiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBBYjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQWIyCkFxd2VydHl1aW9wYXNkZmdoamtsenhjdmJubSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBBejEyMzQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGEyCmIxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBiMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcXdl
cnR5dWlvcGFzZGZnaGprbHp4Y3Zibm0gICAgICAgICAgICAgICAgICAgICAgIHoxMjM0Cg==


--------------bQ2vNlIm7ILeO1tyTk8e32YV--
