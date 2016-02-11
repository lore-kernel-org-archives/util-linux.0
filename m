Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
To: Karel Zak <kzak@redhat.com>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
 <20160211094352.6ncnnirhyd4jjd34@ws.net.home> <56BC9101.60908@suse.cz>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56BCB813.5090300@suse.cz>
Date: Thu, 11 Feb 2016 17:34:27 +0100
MIME-Version: 1.0
In-Reply-To: <56BC9101.60908@suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:
> I am working on a subtest that will trigger it inside the test suite.
>
> I already have a possible fix for it, but I want to confirm that it is
> correct before sending it upstream.
>
I just have a reproducer of the new problem.

The newly found problem is not btrfs speficic:

echo "/ext4.img /ext4_mnt1 auto loop 0 0" >>/etc/fstab
mount -a
echo "/ext4.img /ext4_mnt2 auto loop 0 0" >>/etc/fstab
mount -a
mount
umount /ext4_mnt1 /ext4_mnt2
sed -i /ext4.img/d /etc/fstab

Result:
Nothing was mounted into /ext4_mnt2

(This is the problem with loop files in fstab, which I mentioned in my 
past mails, but was not able to reproduce.)


It also means, that I still don't have a reproducer that will 
demonstrate mount confused by an incorrect subvol provided by kernel.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
