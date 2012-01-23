Return-Path: linux-fsdevel-owner@vger.kernel.org
Subject: Re: /etc/fstab.d yes or not
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Theodore Tso <tytso@MIT.EDU>
In-Reply-To: <CAPXgP11pvch92n1=mMfDsMLoGZMG8xq0e1juXyUO6mxFR6_GYg@mail.gmail.com>
Date: Mon, 23 Jan 2012 08:55:21 -0500
Cc: Theodore Tso <tytso@MIT.EDU>, Roger Leigh <rleigh@codelibre.net>,
        Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org
Message-Id: <ACD4236E-A309-465F-8789-DA3A5B648313@mit.edu>
References: <20120120140444.GC13157@x2.net.home> <20120120154912.GK8797@codelibre.net> <CAPXgP13a9v+f1uNdpe-c+aApLfLpgn15b1-gZxRPd0wMvU=B-Q@mail.gmail.com> <20120120162220.GN8797@codelibre.net> <CAPXgP11pvch92n1=mMfDsMLoGZMG8xq0e1juXyUO6mxFR6_GYg@mail.gmail.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I am extremely dubious about systemd, and would much rather it not be on any system that *I* run (and using UUID's to identify kernel notification is just whacko) , but I have to agree with Kay in that /etc/fstab.d is Just Wrong.   The /etc/fstab file is parsed by many programs, shell scripts, and not just the ones in util-linux.   We should consider it an ABI, and not mess with it.

-- Ted

