Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yb0-f179.google.com ([209.85.213.179]:40667 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754611AbcJXPRw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 24 Oct 2016 11:17:52 -0400
Received: by mail-yb0-f179.google.com with SMTP id h65so1730295ybb.7
        for <util-linux@vger.kernel.org>; Mon, 24 Oct 2016 08:17:51 -0700 (PDT)
MIME-Version: 1.0
From: "Ice \"Zack\" Azilov" <icezackazilov@gmail.com>
Date: Mon, 24 Oct 2016 17:17:10 +0200
Message-ID: <CAKaFfWvpZf=zqbgb8ELe7VQQ=uOUvkyHUmjDH1ut3n0T-Nnjbg@mail.gmail.com>
Subject: Out of order disk partitions calling lsblk.
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello o/

Recently (since 4.8 kernel), I found that lsblk doesn't show output in
alphabetical order like it was before. The block devices doesn't
appear to be classified by UUID or by size.

Ok, I'm not going to die for this, but I'm curious to know what causes this.

I can use "-x NAME" option but I don't have the tree.

Thank you.

--
- IZA
