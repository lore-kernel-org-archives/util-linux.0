Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45375 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab2HNJ5D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Aug 2012 05:57:03 -0400
Received: by obbuo13 with SMTP id uo13so304896obb.19
        for <util-linux@vger.kernel.org>; Tue, 14 Aug 2012 02:57:02 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 14 Aug 2012 05:57:01 -0400
Message-ID: <CAN1hMuBe9PcKvdNr=A3uTgu0JDNT0mVkeDS3T4MNtfjoa40ZsQ@mail.gmail.com>
Subject: column --separator segfaults (patch attached)
From: B Watson <yalhcru@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary=e89a8f643690f712a304c736d499
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--e89a8f643690f712a304c736d499
Content-Type: text/plain; charset=ISO-8859-1

Apologies to list moderator, I attempted to subscribe to the list but
vger's majordomo doesn't seem to like gmail. Anyway:

The --separator and --columns long options in util-linux-2.21.2 and in
a git clone from 5 minutes ago, don't work:

# Short options OK:

$ echo foobar | column -s x
foobar

$ echo foobar | column -c 10
foobar

# Long options bad:

$ echo foobar | column --separator=x
column: option '--separator' doesn't allow an argument

$ echo foobar | column --separator x
Segmentation fault

$ echo foobar | column --columns 10
column: bad columns width value: '(null)': Invalid argument

$ echo foobar | column --columns=10
column: option '--columns' doesn't allow an argument

Looks like a simple case of missing has_arg flag in the "struct option"
initialization for these two options. The patch just adds the flag. I
haven't done thorough testing of the patched code, but it seems to work
OK and it no longer segfaults or tries to dereference a null pointer.

--e89a8f643690f712a304c736d499
Content-Type: application/octet-stream; name="column-fix_long_opts.diff"
Content-Disposition: attachment; filename="column-fix_long_opts.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtTmF1ciB1dGlsLWxpbnV4LTIuMjEuMi90ZXh0LXV0aWxzL2NvbHVtbi5jIHV0aWwtbGlu
dXgtMi4yMS4yLnBhdGNoZWQvL3RleHQtdXRpbHMvY29sdW1uLmMKLS0tIHV0aWwtbGludXgtMi4y
MS4yL3RleHQtdXRpbHMvY29sdW1uLmMJMjAxMi0wNS0yNSAwNTo0NDo1OS4wMDAwMDAwMDAgLTA0
MDAKKysrIHV0aWwtbGludXgtMi4yMS4yLnBhdGNoZWQvL3RleHQtdXRpbHMvY29sdW1uLmMJMjAx
Mi0wOC0xNCAwNToyMjoxNy4wMDAwMDAwMDAgLTA0MDAKQEAgLTEyMSw5ICsxMjEsOSBAQAogCXsK
IAkJeyAiaGVscCIsCTAsIDAsICdoJyB9LAogCQl7ICJ2ZXJzaW9uIiwgICAgMCwgMCwgJ1YnIH0s
Ci0JCXsgImNvbHVtbnMiLAkwLCAwLCAnYycgfSwKKwkJeyAiY29sdW1ucyIsCTEsIDAsICdjJyB9
LAogCQl7ICJ0YWJsZSIsCTAsIDAsICd0JyB9LAotCQl7ICJzZXBhcmF0b3IiLAkwLCAwLCAncycg
fSwKKwkJeyAic2VwYXJhdG9yIiwJMSwgMCwgJ3MnIH0sCiAJCXsgImZpbGxyb3dzIiwJMCwgMCwg
J3gnIH0sCiAJCXsgTlVMTCwJCTAsIDAsIDAgfSwKIAl9Owo=
--e89a8f643690f712a304c736d499--
