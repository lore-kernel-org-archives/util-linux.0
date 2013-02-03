Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f45.google.com ([74.125.83.45]:54231 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab3BCJjx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Feb 2013 04:39:53 -0500
Received: by mail-ee0-f45.google.com with SMTP id b57so2730522eek.4
        for <util-linux@vger.kernel.org>; Sun, 03 Feb 2013 01:39:50 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 3 Feb 2013 01:39:50 -0800
Message-ID: <CAOMFOmWOvh2TAp5a61esH=2Kzgt_YkQ5dHvQOz=_k53zzx20Xg@mail.gmail.com>
Subject: Why "--fake" and "--no-canonicalize" started requiring root in 2.22?
From: Anatol Pomozov <anatol.pomozov@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I am trying to compile and use libfuse. Libfuse utilises 'mount' and
'umount' tools. One of few things it uses are "--fake" and
"--no-canonicalize" command options run as regular user. It worked
fine with previous versions of util-linux (2.20 from Ubuntu Precise).
But in the latest version (2.22 from Arch) it fails to run as a
regular user:

$  mount --version
mount from util-linux 2.22.2 (libmount 2.22.0: debug)
$  mount --fake
mount: only root can use "--fake" option
$  mount --no-canonicalize
mount: only root can use "--no-canonicalize" option

Should it be removed from the list of "restricted" options like it
happened with other options recently? This would restore the same
behavior that "mount" had before.
