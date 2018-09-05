function [Files,FileTable] = InfoExt(FolderPath)
%% ��δ�����ͼƬ�ļ����У�����ͼƬ���ļ�����ȡ���е���Ϣ
% Zhang Pengnian
% ������������LR�����ڡ��ļ���
tic
imds = imageDatastore(FolderPath,'IncludeSubfolders',true,'LabelSource','none');
N = size(imds.Files,1);
FileTable = cell(N,4);

FLAG_DOUBLE = 0;

for i=1:N 
    fp = char(imds.Files(i));
%     fp = imds.Files(i);
%     fp_str = char(fp);
    size_fp = size(fp,2);
%     fp_split = regexp(fp, '-', 'split');
    %% Name
    for j=1:size_fp-2
        if isChinese(fp(size_fp-j)) && isChinese(fp(size_fp-j-1))
            % ���������ҵ������������ĺ��֣���һ�����ֵ�λ����size_fp-j
            NameEndPosition = size_fp-j;
            k=2;
            while isChinese(fp(size_fp-j-k))    
                k=k+1;
            end
            NameStartPosition = NameEndPosition-k+1;
            break;

        end
        if j==size_fp-2
            disp(i);
            disp('��������');
            break;
        end
    end

    Files.Name(i) = cellstr(fp(NameStartPosition:NameEndPosition));
    
    %% Left or Right
%     if fp(size_fp-5)=='-' && fp(size_fp-7)=='-' && (fp(size_fp-6)=='��' || fp(size_fp-6)=='��')
%         FileTable(i,2) = cellstr(fp(size_fp-6));
%     elseif fp(size_fp-6)=='-' && fp(size_fp-8)=='-' && (fp(size_fp-7)=='��' || fp(size_fp-7)=='��')
%         FileTable(i,2) = cellstr(fp(size_fp-7));
%     else
%         disp(i);
%         disp('��/�� ����');
%     end
    for j=1:size_fp-2
        if fp(size_fp-j)=='-' && fp(size_fp-j-2)=='-' && fp(size_fp-j-1)=='��'
            % j��j-2��'-'��j-1�������
            Files.LoR(i) = cellstr('L');
            break;
        elseif fp(size_fp-j)=='-' && fp(size_fp-j-2)=='-' && fp(size_fp-j-1)=='��'
            Files.LoR(i) = cellstr('R');
            break;
        end
        if j==size_fp-2
            disp(i);
            disp('���ҳ���');
            break;
        end
    end
   
    %% Date
    for j=1:size_fp-2
%         if fp(size_fp-j) == '\' 
        if abs('0') <= abs(fp(size_fp-j)) && abs(fp(size_fp-j)) <= abs('9') && abs('0') <= abs(fp(size_fp-j-1)) && abs(fp(size_fp-j-1)) <= abs('9') ...
                && abs('0') <= abs(fp(size_fp-j-3)) && abs(fp(size_fp-j-3)) <= abs('9') && abs('0') <= abs(fp(size_fp-j-4)) && abs(fp(size_fp-j-4)) <= abs('9') ...
                && abs('0') <= abs(fp(size_fp-j-6)) && abs(fp(size_fp-j-6)) <= abs('9') && abs('0') <= abs(fp(size_fp-j-7)) && abs(fp(size_fp-j-7)) <= abs('9') ...
                && abs('0') <= abs(fp(size_fp-j-8)) && abs(fp(size_fp-j-8)) <= abs('9') && abs('0') <= abs(fp(size_fp-j-9)) && abs(fp(size_fp-j-9)) <= abs('9') ...
                && fp(size_fp-j-2) == '-' && fp(size_fp-j-5) == '-'
            Files.Date(i) = cellstr(fp(size_fp-j-9:size_fp-j));
            %             Files.Filepath(i) = cellstr(fp(size_fp-j+1:size_fp));
%             Files.Filepath(i) = cellstr('');
            break;
        end
        if j==size_fp-2
            disp(i);
            disp('���ڳ���');
            break;
        end
    end
    
    %% Filepath
    Files.Filepath(i) = cellstr(imds.Files(i));
            

    %%
    if fix(i/1000) == i/1000
        disp(i);
        toc;
    end
end
FileTable = [Files.Name;Files.LoR;Files.Date;Files.Filepath];

%% Only used in testing
if FLAG_DOUBLE==1
    for i=1:N
        FileTable(i+N,:) = FileTable(i,:);
        Files.Name(i+N) = Files.Name(i);
        Files.LoR(i+N) = Files.LoR(i);
        Files.Date(i+N) = Files.Date(i);
        Files.Filepath(i+N) = Files.Filepath(i);
    end
end
