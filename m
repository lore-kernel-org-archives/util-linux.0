Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:37091 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdBWSeC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 23 Feb 2017 13:34:02 -0500
Date: Thu, 23 Feb 2017 19:15:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libmount: add mnt_fs_is_btrfs()
Message-ID: <20170223181521.3525a2yh2fseznc5@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20170223140444.17916-1-pvorel@suse.cz>
 <20170223151214.y4wh2azmfab3wqra@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170223151214.y4wh2azmfab3wqra@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

>  What's wrong with 

>    strcmp(mnt_fs_get_fstype(fs, "btrfs"))

>  why we need FS specific function exported by API?

I'm sorry I mixed two things. I thought that it could be useful for the others (with
btrfs_get_default_subvol_id()) as IMHO there is no btrfs C library atm [1].

Please forget on that, I'll post just v2 with just second patch.


Kind regards,
Petr

[1] https://btrfs.wiki.kernel.org/index.php/Project_ideas#Provide_a_library_covering_.27btrfs.27_functionality
